import XCTest
@testable import ProCom

final class ProComTests: XCTestCase {
    
    func testProCom() throws {
        
        let proCom = ProCom([.osc], io: .client)
        try proCom.send([true, 1, 1.0], over: [.osc], to: ["test"])
    }
}
