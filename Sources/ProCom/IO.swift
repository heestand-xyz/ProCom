
/// Input / Output
public struct IO: OptionSet, CustomStringConvertible {

    public let rawValue: UInt

    /// Receive data
    public static let client = IO(rawValue: 1 << 0)
    /// Send data
    public static let server = IO(rawValue: 1 << 1)
    
    public static let none: IO = []
    public static let all: IO = [.client, .server]
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        if self == .all {
            "all"
        } else if self == .client {
            "client"
        } else if self == .server {
            "server"
        } else {
            "none"
        }
    }
}
