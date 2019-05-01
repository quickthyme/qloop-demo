import QLoop

struct EditorBehaviors {

    static var ParseScriptAndEnsureNumericResult: QLPath<String, String> {
        return QLPath( ParseJsonText,
                       EnsureNumericResult )!
    }

    private static var ParseJsonText: QLSerialSegment<String, String> {
        let txt = JavaScriptTextTransformer()
        return QLss(txt.id, txt.op, operationQueue: txt.queue)
    }

    private static var EnsureNumericResult: QLSerialSegment<String, String> {
        let ensureNumericOp = GuardNumberText()
        return QLss(ensureNumericOp.id, ensureNumericOp.op)
    }
}
