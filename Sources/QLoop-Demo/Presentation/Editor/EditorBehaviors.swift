
import QLoop
import Dispatch

struct EditorBehaviors {
    static var PerformNumericCalculation: QLPath<String, String> {
        return QLPath(
            ParseJsonText(),
            EnsureNumericResult())!
    }
}

fileprivate extension EditorBehaviors {

    static func ParseJsonText() -> QLSerialSegment<String, String> {
        let parseJsonTextOp = JavaScriptTextTransformer()
        let parseJsonTextSeg = QLss(parseJsonTextOp.id, parseJsonTextOp.op)
        parseJsonTextSeg.operationQueue = DispatchQueue.global(qos: .background)
        return parseJsonTextSeg
    }

    static func EnsureNumericResult() -> QLSerialSegment<String, String> {
        let ensureNumericOp = GuardNumberText()
        return QLss(ensureNumericOp.id, ensureNumericOp.op)
    }
}
