
public struct Message {
    
    let values: [any Value]
    let address: Address
    
    public init(value: any Value, address: Address) {
        self.values = [value]
        self.address = address
    }
    
    public init(values: [any Value], address: Address) {
        self.values = values
        self.address = address
    }
}
