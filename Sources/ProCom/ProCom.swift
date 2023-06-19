
public final class ProCom {
    
    let io: IO
    
    private var proCom: [Com: any Pro] = [:]
    
    public init(_ com: Set<Com>, io: IO) {
        self.io = io
        setup(com: com)
    }
    
    private func setup(com: Set<Com>) {
        for com in com {
            let pro: any Pro = com.pro(io: io)
            proCom[com] = pro
        }
    }
    
    public func send(_ value: Value, over com: Com) {
        
    }
}
