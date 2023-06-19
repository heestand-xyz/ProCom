import Foundation
import OSCKit

public final class OSC: Pro {
    
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
            client = OSCClient(localPort: config.localPort)
        }
        if io.contains(.server) {
            server = OSCServer(port: config.remotePort,
                               receiveQueue: config.queue,
                               dispatchQueue: config.queue,
                               timeTagMode: config.timeTagMode,
                               handler: handler)
        }
    }
}

// MARK: Client

extension OSC {
    
    public func send(_ value: Value) {
        
    }
}

// MARK: Server

extension OSC {
    
    private func handler(message: OSCMessage, timeTag: OSCTimeTag) {
        
    }
}
