
import UIKit

class StoryboardLoader {
    static func loadViewController(from storyboardName: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        return storyboard.instantiateInitialViewController()
    }
}
