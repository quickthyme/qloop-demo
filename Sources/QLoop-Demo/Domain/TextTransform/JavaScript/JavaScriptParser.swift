
import Foundation
import JavaScriptCore

class JavaScriptParser {

    let jsPrefix  = "var parseFunc = function(jsonData) {"
    let jsPostfix = "}"

    func parseString(javaScript: String) -> String {
        guard javaScript != "", let context = JSContext() else { return "" }
        context.evaluateScript("\(jsPrefix) \(javaScript) \(jsPostfix)")
        return context
            .objectForKeyedSubscript("parseFunc")
            .call(withArguments: [])
            .toString()
    }
}
