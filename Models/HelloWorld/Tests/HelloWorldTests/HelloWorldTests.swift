import XCTest
@testable import HelloWorld

final class HelloWorldTests: XCTestCase {
    func testExample() throws {
        let helloWorld: HelloWorldish = HelloWorld(message: "Hello, World!").surrogate()
        XCTAssertEqual(helloWorld.message, "Hello, World!")
        
    }
}
