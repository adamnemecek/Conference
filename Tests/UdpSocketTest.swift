
import XCTest

class UdpSocketTest: XCTestCase {
    
    func testResolveValidHost() {
      let expectation = XCTestExpectation(description: "Resolve valid domain")
      UdpSocket.resolve(host: "www.apple.com", port: 80) { socket in
        XCTAssertNotNil(socket)
        expectation.fulfill()
      }
      wait(for: [expectation], timeout: 10)
    }

}
