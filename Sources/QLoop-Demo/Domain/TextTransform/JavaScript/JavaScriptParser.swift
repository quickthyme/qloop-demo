
import Foundation
import JavaScriptCore

class JavaScriptParser {

    let jsPrefix  = "var parseFunc = function(jsonData) {"
    let jsPostfix = "}"

    func parseString(javaScript: String) -> String {
        guard javaScript != "" else { return "" }
        let script = "\(jsPrefix) \(javaScript) \(jsPostfix)"
        let context = JSContext()!
        context.evaluateScript(script)
        let parseFunc = context.objectForKeyedSubscript("parseFunc")!
        return parseFunc.call(withArguments: [])?.toString() ?? ""
    }

    struct ParseError: Error {
        var msg: String
        var localizedDescription: String { return msg }
        init(_ msg: String) { self.msg = msg }
    }
}
