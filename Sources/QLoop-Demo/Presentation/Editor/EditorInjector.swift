
import UIKit
import QLoop

class EditorInjector: NSObject {
    @IBOutlet weak var editorViewController: EditorViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        editorViewController
            .runActionLoop
            .bind(path: textTransformPath )
    }

    var textTransformPath: QLoopPath<String, String> {
        let bgThread = GlobalThreadOperation<String>(.background)
        let jsonParse = JavaScriptTextTransformer()
        let mainThread = MainThreadOperation<String>()
        let guardNumber = GuardNumberText()

        return QLoopPath<String, String>(
            QLoopLinearSegment(bgThread.id, bgThread.op),
            QLoopLinearSegment(jsonParse.id, jsonParse.op),
            QLoopLinearSegment(mainThread.id, mainThread.op),
            QLoopLinearSegment(guardNumber.id, guardNumber.op)
        )!
    }
}
