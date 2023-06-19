
/// Communication
public enum Com: String, Identifiable, CaseIterable {
    
    /// OSC
    case osc
}

extension Com {
    
    var set: Set {
        switch self {
        case .osc:
            return .osc
        }
    }
    
    public struct Set: OptionSet {

        public let rawValue: UInt

        /// OSC
        public static let osc = Set(rawValue: 1 << 0)
        
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
    }
}

extension Com {
    
    public var id: String { rawValue }
}

extension Com {
    
    public func pro(io: IO) -> any Pro {
        switch self {
        case .osc:
            return OSC(io: io)
        }
    }
}
