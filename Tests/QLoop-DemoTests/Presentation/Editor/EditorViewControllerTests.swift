
import XCTest

class EditorViewControllerTests: XCTestCase {

    var subject: EditorViewController!

    override func setUp() {
        subject = (StoryboardLoader.loadViewController(from: "Editor") as! EditorViewController)
        subject.processTextActionLoop.destroy()
        let _ = subject.view
    }

    func test_has_correct_parseTextActionLoop_configuration() {
        let subject: EditorViewController = (StoryboardLoader.loadViewController(from: "Editor") as! EditorViewController)
        let _ = subject.view
        let opPath = subject.processTextActionLoop.describeOperationPath()
        XCTAssertEqual(opPath, "{js parser}-{guard number text}")
    }

    func test_outlets_connected() {
        XCTAssertNotNil(subject.inputTextView)
        XCTAssertNotNil(subject.outputTextView)
        XCTAssertNotNil(subject.runButton)
        XCTAssertNotNil(subject.runButton.actions(forTarget: subject, forControlEvent: .touchUpInside))
    }

    func test_process_action_performs_loop_with_input_text_view_text() {
        subject.inputTextView.text = "hello"
        subject.processAction(nil)
        XCTAssertEqual(subject.processTextActionLoop.input.value, "hello")
    }

    func test_processTextActionLoop_returns_with_output_it_should_display_it_using_green_text_color() {
        subject.processTextActionLoop.onChange("SUCCESS")
        XCTAssertEqual(subject.outputTextView.text, "SUCCESS")
        XCTAssertEqual(subject.outputTextView.textColor, UIColor.green)
    }

    func test_processTextActionLoop_returns_with_error_it_should_display_it_using_red_text_color() {
        subject.processTextActionLoop.output.onError(DummyError())
        XCTAssertEqual(subject.outputTextView.text, "DummyError()")
        XCTAssertEqual(subject.outputTextView.textColor, UIColor.red)
    }
}
