import Foundation

public struct Const {
    
    public static let queue: DispatchQueue = .global(qos: .userInteractive)
    
    public static let localhost: String = "localhost"
    
    public static let inPort: UInt16 = 10_000
    public static let outPort: UInt16 = 8_000
}
