
import XCTest

class GlobalThreadOperationTests: XCTestCase {
    typealias Completion = (Int?) -> ()
    typealias ErrCompletion = (Error) -> ()
    typealias Operation = (Int?, @escaping Completion) -> ()
    typealias Handler = (Error, @escaping Completion, @escaping ErrCompletion) -> ()

    var subject: GlobalThreadOperation<Int>!

    override func setUp() {
        subject = GlobalThreadOperation(.background)
    }

    func test_has_id() {
        XCTAssertEqual(subject.id, "global_qos_thread_background")
    }

    func test_calling_operation_calls_completion_on_background_thread() throws {
        let expectBackgroundThread = expectation(description: "expectBackgroundThread")
        var thread: Thread? = nil
        let completion: Completion = { _ in
            thread = Thread.current;
            expectBackgroundThread.fulfill()
        }

        subject.op(1, completion)

        wait(for: [expectBackgroundThread], timeout: 1.0)
        XCTAssertNotNil(thread)
        XCTAssertFalse(thread?.isMainThread ?? false)
    }

    func test_calling_handler_calls_error_completion_on_background_thread() throws {
        let expectBackgroundThread = expectation(description: "expectBackgroundThread")
        var thread: Thread? = nil
        let completion: Completion = { _ in }
        let errCompletion: ErrCompletion = { _ in
            thread = Thread.current;
            expectBackgroundThread.fulfill()
        }

        subject.err(MockError(), completion, errCompletion)

        wait(for: [expectBackgroundThread], timeout: 1.0)
        XCTAssertNotNil(thread)
        XCTAssertFalse(thread?.isMainThread ?? false)
    }
}
