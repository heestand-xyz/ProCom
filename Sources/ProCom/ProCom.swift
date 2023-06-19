import os.log
import Collections

public final class ProCom {
    
    private let logger = Logger(subsystem: "ProCom", category: "ProCom")
    
    let io: IO
    
    private var pros: OrderedDictionary<Com, any Pro> = [:]
    
    var osc: OSC? { pros[.osc] as? OSC }
    
    public init(_ coms: Com.Set, io: IO) {
        logger.info("Init of ProCom for IO (\(io, privacy: .public))")
        self.io = io
        setup(coms: coms)
    }
    
    private func setup(coms: Com.Set) {
        for com in Com.allCases {
            guard coms.contains(com.set) else { continue }
            logger.info("Setup of Com (\(com.rawValue, privacy: .public))")
            let pro: any Pro = com.pro(io: io)
            pros[com] = pro
        }
    }
    
    public func send(_ message: Message, over coms: Com.Set) throws {
        logger.info("Send (\(message, privacy: .public))")
        for com in Com.allCases {
            guard coms.contains(com.set) else { continue }
            logger.info("Send over Com (\(com.rawValue, privacy: .public))")
            guard let pro: any Pro = pros[com] else {
                logger.warning("Com \(com.rawValue, privacy: .public) not in init")
                continue
            }
            try pro.send(message)
        }
    }
    
    public func receive(over coms: Com.Set) -> AsyncStream<Message> {
        logger.info("Receive start over Com (\(coms.coms, privacy: .public))")
        let (stream, continuation) = AsyncStream.makeStream(of: Message.self)
        for com in Com.allCases {
            guard coms.contains(com.set) else { continue }
            guard let pro: any Pro = pros[com] else {
                logger.warning("Com \(com.rawValue, privacy: .public) not in init")
                continue
            }
            Task {
                for await message in pro.receive() {
                    logger.info("Receive (\(message))")
                    continuation.yield(message)
                }
            }
        }
        continuation.onTermination = { [weak self] _ in
            self?.logger.info("Receive ended over Com (\(coms.coms, privacy: .public))")
        }
        return stream
    }
}
