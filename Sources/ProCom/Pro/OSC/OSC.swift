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
    
    public func send(_ values: [any Value], to address: [String]) throws {
        guard let client: OSCClient else {
            logger.warning("IO not set to use client")
            return
        }
        if address.isEmpty {
            logger.warning("Address is empty")
            return
        }
        let message = OSCMessage(addressPattern: address, values: values)
        try client.send(message, to: config.ipAddress, port: config.outPort)
    }
}

// MARK: Server

extension OSC {
    
    private func handler(message: OSCMessage, timeTag: OSCTimeTag) {
        
    }
}
