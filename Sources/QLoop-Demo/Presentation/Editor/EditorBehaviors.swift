
import QLoop

struct EditorBehaviors {

    static var PerformNumericCalculation: QLPath<String, String> {
        return QLPath( ParseJsonText,
                       EnsureNumericResult )!
    }

    private static var ParseJsonText: QLSerialSegment<String, String> {
        let txt = JavaScriptTextTransformer()
        let seg = QLss(txt.id, txt.op)
        seg.operationQueue = txt.queue
        return seg
    }

    private static var EnsureNumericResult: QLSerialSegment<String, String> {
        let ensureNumericOp = GuardNumberText()
        return QLss(ensureNumericOp.id, ensureNumericOp.op)
    }
}
