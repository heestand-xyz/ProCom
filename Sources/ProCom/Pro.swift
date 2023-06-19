
public protocol Pro: AnyObject {
    
    var io: IO { get set }
    
    associatedtype C: Config
    var config: C { get set }
    
    init()
    
    func send(_ value: Value)
}
