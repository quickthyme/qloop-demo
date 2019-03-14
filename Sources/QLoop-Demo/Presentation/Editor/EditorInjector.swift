
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
        let bgThreadSegment =
            QLoopGlobalThreadOperation<String>.constructSegment(.background)
        let jsonParse = JavaScriptTextTransformer()
        let guardNumber = GuardNumberText()
        let mainThreadSegment =
            QLoopMainThreadOperation<String>.constructSegment()

        return QLoopPath<String, String>(
            bgThreadSegment,
            QLoopLinearSegment(jsonParse.id, jsonParse.op),
            QLoopLinearSegment(guardNumber.id, guardNumber.op),
            mainThreadSegment
        )!
    }
}
