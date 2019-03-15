
import UIKit
import QLoop

class EditorInjector: NSObject {
    @IBOutlet weak var editorViewController: EditorViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        editorViewController
            .parseTextActionLoop
            .bind(path: textTransformPath )
    }

    var textTransformPath: QLoopPath<String, String> {
        let bgThread = QLoopCommon.Operation.DispatchGlobal<String>(.background)
        let jsonParse = JavaScriptTextTransformer()
        let guardNumber = GuardNumberText()
        let mainThread = QLoopCommon.Operation.DispatchMain<String>()

        return QLoopPath<String, String>(
            QLoopLinearSegment(bgThread.id, bgThread.op),
            QLoopLinearSegment(jsonParse.id, jsonParse.op),
            QLoopLinearSegment(guardNumber.id, guardNumber.op),
            QLoopLinearSegment(mainThread.id, mainThread.op,
                               errorHandler: mainThread.err)
        )!
    }
}
