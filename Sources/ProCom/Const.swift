import Foundation

public struct Const {
    
    public static let queue: DispatchQueue = .global(qos: .userInteractive)
    
    public static let localPort: UInt16 = 10_000
    public static let remotePort: UInt16 = 8_000
}
