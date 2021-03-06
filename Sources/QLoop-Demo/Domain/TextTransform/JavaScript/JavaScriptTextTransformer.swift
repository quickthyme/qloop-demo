
import Dispatch

struct JavaScriptTextTransformer {
    let id: String = "js parser"

    let queue: DispatchQueue = DispatchQueue.global(qos: .background)

    var op: TextTransform {
        return ({ input, completion in
            let parser = JavaScriptParser()
            let result = parser.parse(input)
            completion(result)
        })
    }
}
