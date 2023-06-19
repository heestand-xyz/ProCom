import Foundation
import OSCKit

public struct OSCConfig: Config {
    
    public var queue: DispatchQueue
    
    public var ipAddress: String
    
    public var inPort: UInt16
    public var outPort: UInt16
    
    public var timeTagMode: OSCTimeTagMode
    
    public init(queue: DispatchQueue = Const.queue,
                ipAddress: String = Const.localhost,
                inPort: UInt16 = Const.inPort,
                outPort: UInt16 = Const.outPort,
                timeTagMode: OSCTimeTagMode = .ignore) {
        self.queue = queue
        self.ipAddress = ipAddress
        self.inPort = inPort
        self.outPort = outPort
        self.timeTagMode = timeTagMode
    }
}
