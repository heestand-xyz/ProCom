import Foundation
import OSCKit

public struct OSCConfig: Config {
    
    public let queue: DispatchQueue
    
    public let localPort: UInt16
    public let remotePort: UInt16
    
    public let timeTagMode: OSCTimeTagMode
    
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
