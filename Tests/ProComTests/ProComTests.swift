import XCTest
@testable import ProCom

final class ProComTests: XCTestCase {
    
    func testProCom() throws {
        
        let proCom = ProCom(.osc, io: .client)
        let message = Message(value: 123, address: Address("test"))
        try proCom.send(message, over: .osc)
    }
}
