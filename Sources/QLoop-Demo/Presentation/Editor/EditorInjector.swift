
import UIKit
import QLoop

class EditorInjector: NSObject {
    @IBOutlet weak var editorViewController: EditorViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        editorViewController.processTextActionLoop
            .bind(path: EditorBehaviors.PerformNumericCalculationThenOutputResults)
    }
}
