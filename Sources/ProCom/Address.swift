import OSCKit

public struct Address: Equatable, CustomStringConvertible {
    
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
    
    public var description: String {
        "/" + pattern.joined(separator: "/")
    }
}

extension Address {
    var osc: OSCAddressPattern {
        OSCAddressPattern(pathComponents: pattern)
    }
}
