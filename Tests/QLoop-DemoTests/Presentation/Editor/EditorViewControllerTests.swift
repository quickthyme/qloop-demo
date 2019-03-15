
import XCTest

class EditorViewControllerTests: XCTestCase {

    var subject: EditorViewController!

    override func setUp() {
        subject = (StoryboardLoader.loadViewController(from: "Editor") as! EditorViewController)
        subject.parseTextActionLoop.destroy()
        let _ = subject.view
    }

    func test_has_correct_parseTextActionLoop_configuration() {
        let subject: EditorViewController = (StoryboardLoader.loadViewController(from: "Editor") as! EditorViewController)
        let _ = subject.view
        let opPath = subject.parseTextActionLoop.describeOperationPath()
        XCTAssertEqual(opPath,
                       "{global_qos_thread_background}"
                        + "-{js parser}"
                        + "-{guard number text}"
                        + "-{main_thread*}")
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
        XCTAssertEqual(subject.parseTextActionLoop.inputAnchor.value, "hello")
    }

    func test_parseTextActionLoop_returns_with_output_it_should_display_it_using_white_text_color() {
        subject.parseTextActionLoop.outputAnchor.value = "SUCCESS"
        XCTAssertEqual(subject.outputTextView.text, "SUCCESS")
        XCTAssertEqual(subject.outputTextView.textColor, UIColor.white)
    }

    func test_parseTextActionLoop_returns_with_error_it_should_display_it_using_red_text_color() {
        subject.parseTextActionLoop.outputAnchor.error = DummyError()
        XCTAssertEqual(subject.outputTextView.text, "DummyError()")
        XCTAssertEqual(subject.outputTextView.textColor, UIColor.red)
    }
}
