import XCTest
@testable import ProCom

@available(iOS 16.0, macOS 13.0, *)
final class ProComTests: XCTestCase {
    
    func testProCom() async throws {
        
        let port: UInt16 = .random(in: 1_000...10_000)
        
        let proComOut = ProCom(over: .osc, io: .out)
        
        proComOut.osc?.config.outPort = port
        
        let proComIn = ProCom(over: .osc, io: .in)
        proComIn.osc?.config.inPort = port
        
        let inTask = Task<Message?, Error> {
            for await message in proComIn.receive(over: .osc) {
                return message
            }
            return nil
        }
        
        let timeoutTask = Task {
            try? await Task.sleep(for: .seconds(2.0))
            inTask.cancel()
        }
        
        let outValue: Int32 = 123
        let outMessage = Message(value: outValue, address: Address("test"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            try! proComOut.send(outMessage, over: .osc)
        }
        
        let inMessage: Message? = try await inTask.value
        timeoutTask.cancel()
        
        XCTAssertEqual(inMessage, outMessage)
    }
}
