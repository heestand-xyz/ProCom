import Foundation

public protocol Config: Hashable {
    var queue: DispatchQueue { get }
}
