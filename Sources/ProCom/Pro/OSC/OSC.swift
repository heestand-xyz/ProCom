import Foundation
import OSCKit

public final class OSC: Pro {
    
    public var io: IO = .none {
        didSet {
            setup()
        }
    }
    
    public var config = OSCConfig() {
        didSet {
            setup()
        }
    }
    
    var client: OSCClient?
    var server: OSCServer?
    
    public init() {}
    
    private func setup() {
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
