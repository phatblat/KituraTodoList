import KituraTodoListCore
import XCTest

class KituraTodoListTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(TodoItem().id, "")
    }

    static var allTests: [(String, (KituraTodoListTests) -> () -> Void)] = [
        ("testExample", testExample),
    ]
}
