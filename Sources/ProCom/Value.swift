import CoreGraphics
import OSCKit

enum ValueType: CaseIterable {
    case float
    case double
    case int32
    case int
    case string
    static func cast(_ value: Any) -> (any Value)? {
        for valueType in Self.allCases {
            if let value = valueType.cast(value) {
                return value
            }
        }
        return nil
    }
    func cast(_ value: Any) -> (any Value)? {
        switch self {
        case .float:
            return value as? Float
        case .double:
            return value as? Double
        case .int32:
            return value as? Int32
        case .int:
            return value as? Int
        case .string:
            return value as? String
        }
    }
}

public protocol Value: Equatable, CustomStringConvertible, OSCValue {}

extension Bool: Value {}
extension Int32: Value {}
extension Int: Value {}
extension Float: Value {}
extension Double: Value {}
extension String: Value {}

extension Value {
    func isEqual(to value: any Value) -> Bool {
        guard let value = value as? Self else { return false }
        return self == value
    }
}
