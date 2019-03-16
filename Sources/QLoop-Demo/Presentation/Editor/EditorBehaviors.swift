
import QLoop
import Dispatch

struct EditorBehaviors {

    static var PerformNumericCalculationThenOutputResults: QLPath<String, String> {

        let switchToBkgOp = QLCommon.Op.DispatchGlobal<String>(.background)
        let parseJsonText = JavaScriptTextTransformer()
        let ensureNumeric = GuardNumberText()
        let returnToMain  = QLCommon.Op.DispatchMain<String>()

        return QLPath<String, String>(
            QLss(switchToBkgOp.id, switchToBkgOp.op),
            QLss(parseJsonText.id, parseJsonText.op),
            QLss(ensureNumeric.id, ensureNumeric.op),
            QLss(returnToMain.id,  returnToMain.op,
                 errorHandler: returnToMain.err))!
    }
}
