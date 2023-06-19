import Foundation

public protocol Config: Hashable {
    
    var queue: DispatchQueue { get }
    
    var ipAddress: String { get }
    
    var inPort: UInt16 { get }
    var outPort: UInt16 { get }
}
