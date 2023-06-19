import CoreGraphics
import OSCKit

public protocol Value: OSCValue {}

extension Bool: Value {}
extension Int: Value {}
extension Double: Value {}
extension String: Value {}
