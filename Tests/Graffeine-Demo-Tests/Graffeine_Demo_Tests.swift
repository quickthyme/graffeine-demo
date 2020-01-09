import XCTest
@testable import Graffeine_Demo

class Graffeine_Demo_Tests: XCTestCase {

    func test_library_symbol_protection() {
        XCTAssertNotNil(_GraffeineViewClass)
    }
}
