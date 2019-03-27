
import XCTest

class JavaScriptTextTransformTests: XCTestCase {

    var subject: JavaScriptTextTransformer!

    override func setUp() {
        subject = JavaScriptTextTransformer()
    }

    func test_has_id() {
        XCTAssertEqual(subject.id, "js parser")
    }

    func test_calling_operation_with_nil_should_complete_with_empty_string() throws {
        let (captured, completion) = Captured<String>.captureCompletionOptional()

        try subject.op(nil, completion)

        XCTAssertTrue(captured.didHappen)
        XCTAssertEqual(captured.value, "")
    }

    func test_calling_operation_parses_text_as_javascript_function() throws {
        let (captured, completion) = Captured<String>.captureCompletionOptional()
        let input = "return 2 + 2;"

        try subject.op(input, completion)

        XCTAssertTrue(captured.didHappen)
        XCTAssertEqual(captured.value, "4")
    }
}
