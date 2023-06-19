
/// Protocol
public protocol Pro: AnyObject {
    
    var io: IO { get set }
    
    associatedtype C: Config
    var config: C { get set }

    /// Automatic setup when ``io`` or ``config`` is changed
    var autoSetup: Bool { get set }
    
    init(io: IO, config: C)
    
    /// Setup is called automatically when changing ``io`` or ``config``
    ///
    /// Set ``autoSetup`` to `false` to disable auto setup.
    func setup()
    
    /// Send a value
    func send(_ value: Value)
}
