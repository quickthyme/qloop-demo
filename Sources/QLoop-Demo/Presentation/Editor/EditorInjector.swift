
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
        let guardNumber = GuardNumberText()
        let mainThread = MainThreadOperation<String>()

        return QLoopPath<String, String>(
            QLoopLinearSegment(bgThread.id, bgThread.op,
                               errorHandler: bgThread.err),
            QLoopLinearSegment(jsonParse.id, jsonParse.op),
            QLoopLinearSegment(guardNumber.id, guardNumber.op),
            QLoopLinearSegment(mainThread.id, mainThread.op,
                               errorHandler: mainThread.err)
        )!
    }
}
