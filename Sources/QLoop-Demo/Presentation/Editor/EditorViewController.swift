import UIKit
import QLoop

class EditorViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var runButton: UIButton!

    @IBAction func processAction(_ sender: AnyObject?) {
        processTextActionLoop.perform(inputTextView.text)
    }

    lazy var processTextActionLoop = QLoop<String, String>(
        iterator: QLoopIteratorSingle(),

        onChange: ({ text in
            self.outputTextView.textColor = UIColor.green
            self.outputTextView.text = text
        }),

        onError: ({ error in
            self.outputTextView.textColor = UIColor.red
            self.outputTextView.text = "\(error)"
        }))
}
