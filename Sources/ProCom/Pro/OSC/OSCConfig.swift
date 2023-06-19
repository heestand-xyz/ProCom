import Foundation
import OSCKit

public struct OSCConfig: Config {
    
    public var queue: DispatchQueue
    
    public var localPort: UInt16
    public var remotePort: UInt16
    
    public var timeTagMode: OSCTimeTagMode
    
    public init(queue: DispatchQueue = Const.queue,
                localPort: UInt16 = Const.localPort,
                remotePort: UInt16 = Const.remotePort,
                timeTagMode: OSCTimeTagMode = .ignore) {
        self.queue = queue
        self.localPort = localPort
        self.remotePort = remotePort
        self.timeTagMode = timeTagMode
    }
}
