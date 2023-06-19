
public struct Message: CustomStringConvertible {
    
    let address: Address
    let values: [any Value]
    
    public init(value: any Value, address: Address) {
        self.values = [value]
        self.address = address
    }
    
    public init(values: [any Value], address: Address) {
        self.values = values
        self.address = address
    }
    
    public var description: String {
        "message(address: \(address), values: [\(values.map(\.description).joined(separator: ", "))])"
    }
}

extension Message: Equatable {
    
    public static func == (lhs: Message, rhs: Message) -> Bool {
        guard lhs.address == rhs.address else { return false }
        guard lhs.values.count == rhs.values.count else { return false }
        for (lhsValue, rhsValue) in zip(lhs.values, rhs.values) {
            guard lhsValue.isEqual(to: rhsValue) else { return false }
        }
        return true
    }
}
