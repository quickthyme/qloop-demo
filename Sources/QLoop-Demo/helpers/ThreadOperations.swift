
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

struct GlobalThreadOperation<Input> {
    typealias Completion = (Input?) -> ()
    typealias ErrCompletion = (Error) -> ()
    typealias Operation = (Input?, @escaping Completion) -> ()
    typealias Handler = (Error, @escaping Completion, @escaping ErrCompletion) -> ()

    let id: String
    let qosClass: DispatchQoS.QoSClass

    init(_ qosClass: DispatchQoS.QoSClass) {
        self.id = "global_qos_thread_\(qosClass)"
        self.qosClass = qosClass
    }

    var op: Operation {
        let qos = qosClass
        return ({ input, completion in
            DispatchQueue.global(qos: qos).async {
                completion(input)
            }
        })
    }

    var err: Handler {
        let qos = qosClass
        return ({ error, _, errCompletion in
            DispatchQueue.global(qos: qos).async {
                errCompletion(error)
            }
        })
    }
}


