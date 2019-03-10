
import XCTest

class JavaScriptTextTransformTests: XCTestCase {

    var subject: JavaScriptTextTransformer!

    override func setUp() {
        subject = JavaScriptTextTransformer()
    }

    func test_has_id() {
        XCTAssertEqual(subject.id, "js parser")
    }

    func test_calling_operation_parses_text_as_javascript_function() throws {
        let (captured, completion) = Captured<String>.captureCompletionOptional()
        let input = "return 2 + 2;"

        try subject.op(input, completion)

        XCTAssertTrue(captured.didHappen)
        XCTAssertEqual(captured.value, "4")
    }

    func test_calling_operation_fails_it_throws_error() {
        let (captured, completion) = Captured<String>.captureCompletionOptional()
        let input = "return 7 *"

        XCTAssertThrowsError(try subject.op(input, completion))

        XCTAssertFalse(captured.didHappen)
    }
}
