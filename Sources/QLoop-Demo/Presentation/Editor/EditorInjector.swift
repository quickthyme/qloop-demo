
import UIKit
import QLoop

class EditorInjector: NSObject {
    @IBOutlet weak var editorViewController: EditorViewController!

    func TextTransformerSegment() -> QLoopLinearSegment<String, String> {
        return QLoopLinearSegment("TrasformText", EditorTextTransformer())
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        editorViewController.runActionLoop
            .bind(path: QLoopPath(TextTransformerSegment())!)
    }
}

