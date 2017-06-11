import XCTest
@testable import KituraTodoList

class KituraTodoListTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KituraTodoList().text, "Hello, World!")
    }


    static var allTests: [(String, (KituraTodoListTests) -> () -> Void)] = [
        ("testExample", testExample),
    ]
}
