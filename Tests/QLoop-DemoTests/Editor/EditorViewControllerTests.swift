
import XCTest

class EditorViewControllerTests: XCTestCase {

    var subject: EditorViewController!

    override func setUp() {
        subject = (StoryboardLoader.loadViewController(from: "Editor") as! EditorViewController)
        subject.runActionLoop.bind(path: StubLoopPath())
        let _ = subject.view
    }

    func test_has_correct_runActionLoop_configuration() {
        let subject: EditorViewController = (StoryboardLoader.loadViewController(from: "Editor") as! EditorViewController)
        let _ = subject.view
        XCTAssertEqual(subject.runActionLoop.outputAnchor.backwardOwner?.operationIds, ["js parser"])
    }

    func test_outlets_connected() {
        XCTAssertNotNil(subject.inputTextView)
        XCTAssertNotNil(subject.outputTextView)
        XCTAssertNotNil(subject.runButton)
        XCTAssertNotNil(subject.runButton.actions(forTarget: subject, forControlEvent: .touchUpInside))
    }

    func test_run_action_performs_loop_with_input_text_view_text() {
        subject.inputTextView.text = "hello"
        subject.runAction(nil)
        XCTAssertEqual(subject.runActionLoop.inputAnchor.input, "hello")
    }

    func test_runActionLoop_returns_with_output_it_should_display_it_using_white_text_color() {
        subject.runActionLoop.outputAnchor.input = "SUCCESS"
        XCTAssertEqual(subject.outputTextView.text, "SUCCESS")
        XCTAssertEqual(subject.outputTextView.textColor, UIColor.white)
    }

    func test_runActionLoop_returns_with_error_it_should_display_it_using_red_text_color() {
        subject.runActionLoop.outputAnchor.error = MockError()
        XCTAssertEqual(subject.outputTextView.text, "MockError()")
        XCTAssertEqual(subject.outputTextView.textColor, UIColor.red)
    }
}
