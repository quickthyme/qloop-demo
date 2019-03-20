
import UIKit

class EditorBinder: NSObject {
    @IBOutlet weak var editorViewController: EditorViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        editorViewController.processTextActionLoop
            .bind(path: EditorBehaviors.PerformNumericCalculation)
    }
}
