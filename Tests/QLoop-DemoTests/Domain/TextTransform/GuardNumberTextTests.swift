
import XCTest

class GuardNumberTextTests: XCTestCase {

    var subject: GuardNumberText!

    override func setUp() {
        subject = GuardNumberText()
    }

    func test_has_id() {
        XCTAssertEqual(subject.id, "guard number text")
    }

    func test_calling_operation_with_numeric_text_forwards_the_original_text() throws {
        let (captured, completion) = Captured<String>.captureCompletionOptional()
        let input = "144.98"

        try subject.op(input, completion)

        XCTAssertTrue(captured.didHappen)
        XCTAssertEqual(captured.value, "144.98")
    }

    func test_calling_operation_fails_it_throws_error() {
        let (captured, completion) = Captured<String>.captureCompletionOptional()
        let input = "return \"hello\";"

        XCTAssertThrowsError(try subject.op(input, completion))
        XCTAssertFalse(captured.didHappen)
    }
}
