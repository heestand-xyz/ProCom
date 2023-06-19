import os.log
import Foundation
import OSCKit

public final class OSC: Pro {
    
    private let logger = Logger(subsystem: "ProCom", category: "OSC")
    
    public var autoSetup: Bool = true {
        didSet {
            if autoSetup {
                setup()
            }
        }
    }
    
    public var io: IO {
        didSet {
            if autoSetup {
                setup()
            }
        }
    }
    
    public var config: OSCConfig {
        didSet {
            if autoSetup {
                setup()
            }
        }
    }
    
    var client: OSCClient?
    var server: OSCServer?
    
    private var continuations: [AsyncStream<Message>.Continuation] = []
    
    public init(io: IO, config: OSCConfig = .init()) {
        self.io = io
        self.config = config
    }
    
    public func setup() {
        client = nil
        server = nil
        if io.contains(.client) {
            client = OSCClient()
        }
        if io.contains(.server) {
            server = OSCServer(port: config.inPort,
                               receiveQueue: config.queue,
                               dispatchQueue: config.queue,
                               timeTagMode: config.timeTagMode,
                               handler: handler)
        }
    }
}

// MARK: Client

extension OSC {
    
    public func send(_ message: Message) throws {
        guard let client: OSCClient else {
            logger.warning("IO not set to use client")
            return
        }
        if message.address.pattern.isEmpty {
            logger.warning("Address is empty")
            return
        }
        let oscMessage = OSCMessage(message.address.osc, values: message.values)
        try client.send(oscMessage, to: config.ipAddress, port: config.outPort)
    }
}

// MARK: Server

extension OSC {
    
    public func receive() -> AsyncStream<Message> {
        let (stream, continuation) = AsyncStream.makeStream(of: Message.self)
        continuations.append(continuation)
        return stream
    }
    
    private func handler(message: OSCMessage, timeTag: OSCTimeTag) {
        let values: [any Value] = message.values.compactMap({ $0 as? any Value })
        let address = Address(osc: message.addressPattern)
        let message = Message(values: values, address: address)
        for continuation in continuations {
            continuation.yield(message)
        }
    }
}
