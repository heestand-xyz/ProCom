
/// Input / Output
public struct IO: OptionSet, CustomStringConvertible {

    public let rawValue: UInt

    /// Receive data
    public static let out = IO(rawValue: 1 << 0)
    /// Send data
    public static let `in` = IO(rawValue: 1 << 1)
    
    public static let none: IO = []
    public static let all: IO = [.out, .`in`]
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        if self == .all {
            "all"
        } else if self == .out {
            "out"
        } else if self == .`in` {
            "in"
        } else {
            "none"
        }
    }
}
