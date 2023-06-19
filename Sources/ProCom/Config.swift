import Foundation

public protocol Config: Hashable {
    
    var queue: DispatchQueue { get set }
    
    var ipAddress: String { get set }
    
    var inPort: UInt16 { get set }
    var outPort: UInt16 { get set }
}
