import OSCKit

public struct Address {
    
    public var pattern: [String]
    
    init(_ components: String) {
        pattern = components.split(separator: "/").map(String.init)
    }
    
    init(_ pattern: [String]) {
        self.pattern = pattern
    }
    
    init(osc: OSCAddressPattern) {
        pattern = osc.pathComponents.map(String.init)
    }
}

extension Address {
    var osc: OSCAddressPattern {
        OSCAddressPattern(pathComponents: pattern)
    }
}
