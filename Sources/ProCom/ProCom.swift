import os.log

public final class ProCom {
    
    private let logger = Logger(subsystem: "ProCom", category: "ProCom")
    
    let io: IO
    
    private var proCom: [Com: any Pro] = [:]
    
    public init(_ coms: Com.Set, io: IO) {
        self.io = io
        setup(coms: coms)
    }
    
    private func setup(coms: Com.Set) {
        for com in Com.allCases {
            guard coms.contains(com.set) else { continue }
            let pro: any Pro = com.pro(io: io)
            proCom[com] = pro
        }
    }
    
    public func send(_ message: Message, over coms: Com.Set) throws {
        for com in Com.allCases {
            guard coms.contains(com.set) else { continue }
            guard let pro: any Pro = proCom[com] else {
                logger.warning("Com \(com.rawValue, privacy: .public) not in init")
                continue
            }
            try pro.send(message)
        }
    }
}
