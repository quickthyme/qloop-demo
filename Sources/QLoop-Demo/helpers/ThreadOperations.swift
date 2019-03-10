
import Foundation

struct MainThreadOperation<Input> {
    typealias Completion = (Input?) -> ()
    typealias Operation = (Input?, @escaping Completion) -> ()

    let id: String = "main_thread"

    var op: Operation {
        return ({ input, completion in
            DispatchQueue.main.async {
                completion(input)
            }
        })
    }
}

struct GlobalThreadOperation<Input> {
    typealias Completion = (Input?) -> ()
    typealias Operation = (Input?, @escaping Completion) -> ()

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
}


