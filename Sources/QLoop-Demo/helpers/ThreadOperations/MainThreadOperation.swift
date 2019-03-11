
import Foundation

struct MainThreadOperation<Input> {
    typealias Completion = (Input?) -> ()
    typealias ErrCompletion = (Error) -> ()
    typealias Operation = (Input?, @escaping Completion) -> ()
    typealias Handler = (Error, @escaping Completion, @escaping ErrCompletion) -> ()

    let id: String = "main_thread"

    var op: Operation {
        return ({ input, completion in
            DispatchQueue.main.async {
                completion(input)
            }
        })
    }

    var err: Handler {
        return ({ error, _, errCompletion in
            DispatchQueue.main.async {
                errCompletion(error)
            }
        })
    }
}
