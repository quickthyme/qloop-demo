
import UIKit
import QLoop

class EditorViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var runButton: UIButton!

    @IBAction func runAction(_ sender: AnyObject?) {
        runActionLoop.perform(inputTextView.text)
    }

    lazy var runActionLoop = QLoop<String, String>(
        iterator: QLoopIteratorSingle(),

        onChange: ({ text in
            self.outputTextView.textColor = UIColor.white
            self.outputTextView.text = text
        }),

        onError: ({ error in
            self.outputTextView.textColor = UIColor.red
            self.outputTextView.text = "\(error)"
        }))
}
