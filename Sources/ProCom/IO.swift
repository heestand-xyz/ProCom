
public struct IO: OptionSet {

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
}
