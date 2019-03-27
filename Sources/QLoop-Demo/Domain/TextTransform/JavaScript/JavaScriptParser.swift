
import Foundation
import JavaScriptCore

class JavaScriptParser {

    func parse(_ js: String?) -> String {
        guard let js = js, (!js.isEmpty), let vm = JSContext() else { return "" }
        vm.evaluateScript("var parf = function() { \(js) }")
        return vm.objectForKeyedSubscript("parf")
            .call(withArguments: [])
            .toString()
    }
}
