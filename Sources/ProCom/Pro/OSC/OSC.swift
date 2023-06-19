import os.log
import Foundation
import Collections
import OSCKit

public final class OSC: Pro {
    
    private let logger = Logger(subsystem: "ProCom", category: "OSC")
    
    public var autoSetup: Bool = true {
        didSet {
            setupIfAuto()
        }
    }
    
    public var io: IO {
        didSet {
            setupIfAuto()
        }
    }
    
    public var config: OSCConfig {
        didSet {
            setupIfAuto()
        }
    }
    
    var client: OSCClient?
    var server: OSCServer?
    
    private var continuations: OrderedDictionary<UUID, AsyncStream<Message>.Continuation> = [:]
    
    public init(io: IO, config: OSCConfig = .init()) {
        self.io = io
        self.config = config
    }
    
    private func setupIfAuto() {
        if autoSetup {
            do {
                try setup()
            } catch {
                logger.error("OSC Auto Setup Failed")
            }
        }
    }
    
    public func setup() throws {
        server?.stop()
        client = nil
        server = nil
        if io.contains(.out) {
            client = OSCClient()
        }
        if io.contains(.in) {
            server = OSCServer(port: config.inPort,
                               receiveQueue: config.queue,
                               dispatchQueue: config.queue,
                               timeTagMode: config.timeTagMode,
                               handler: handler)
            try server?.start()
        }
    }
}

// MARK: Client

extension OSC {
    
    public func send(_ message: Message) throws {
        guard let client: OSCClient else {
            logger.warning("OSC IO not set to use client")
            return
        }
        if message.address.pattern.isEmpty {
            logger.warning("OSC Address is empty")
            return
        }
        logger.info("Send OSC (\(message, privacy: .public))")
        let oscMessage = OSCMessage(message.address.osc, values: message.values)
        try client.send(oscMessage, to: config.ipAddress, port: config.outPort)
    }
}

// MARK: Server

extension OSC {
    
    public func receive() -> AsyncStream<Message> {
        let id = UUID()
        let (stream, continuation) = AsyncStream.makeStream(of: Message.self)
        continuations[id] = continuation
        continuation.onTermination = { [weak self] _ in
            self?.continuations.removeValue(forKey: id)
        }
        return stream
    }
    
    private func handler(message: OSCMessage, timeTag: OSCTimeTag) {
        print("------->", type(of: message.values.first!))
        let values: [any Value] = message.values.compactMap({ ValueType.cast($0) })
        let address = Address(osc: message.addressPattern)
        let message = Message(values: values, address: address)
        logger.info("Receive OSC (\(message, privacy: .public))")
        for (_, continuation) in continuations {
            continuation.yield(message)
        }
    }
}
