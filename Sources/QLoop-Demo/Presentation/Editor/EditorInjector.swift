
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
        let tx = JavaScriptTextTransformer()
        return QLoopPath(QLoopLinearSegment(tx.id, tx.op))!
    }
}
