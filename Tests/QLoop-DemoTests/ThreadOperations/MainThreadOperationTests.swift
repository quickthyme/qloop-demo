
import XCTest

class MainThreadOperatorTests: XCTestCase {
    typealias Completion = (Int?) -> ()
    typealias ErrCompletion = (Error) -> ()
    typealias Operation = (Int?, @escaping Completion) -> ()
    typealias Handler = (Error, @escaping Completion, @escaping ErrCompletion) -> ()

    var subject: MainThreadOperation<Int>!

    override func setUp() {
        subject = MainThreadOperation()
    }

    func test_has_id() {
        XCTAssertEqual(subject.id, "main_thread")
    }

    func test_calling_operation_calls_completion_on_main_thread() throws {
        let expectMainThread = expectation(description: "expectMainThread")
        var thread: Thread? = nil
        let completion: Completion = { _ in
            thread = Thread.current;
            expectMainThread.fulfill()
        }

        subject.op(1, completion)

        wait(for: [expectMainThread], timeout: 1.0)
        XCTAssertNotNil(thread)
        XCTAssertTrue(thread?.isMainThread ?? false)
    }

    func test_calling_handler_calls_error_completion_on_main_thread() throws {
        let expectMainThread = expectation(description: "expectMainThread")
        var thread: Thread? = nil
        let completion: Completion = { _ in }
        let errCompletion: ErrCompletion = { _ in
            thread = Thread.current;
            expectMainThread.fulfill()
        }

        subject.err(MockError(), completion, errCompletion)

        wait(for: [expectMainThread], timeout: 1.0)
        XCTAssertNotNil(thread)
        XCTAssertTrue(thread?.isMainThread ?? false)
    }
}
