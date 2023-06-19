
/// Communication
public enum Com: String, Identifiable, CaseIterable {
    
    case osc
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
