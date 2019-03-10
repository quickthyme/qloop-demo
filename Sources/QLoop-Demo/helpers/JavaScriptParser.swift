
import Foundation
import JavaScriptCore

typealias JavaScriptTextTransform = (((String?), (String?) -> ()) throws ->())

func JavaScriptTextTransformer() -> JavaScriptTextTransform {
    return ({ input, completion in
        let parser = JavaScriptParser()
        let result: String = try parser.parseString(javaScript: input ?? "")
        completion(result)
    })
}

class JavaScriptParser {

    let jsPrefix  = "var parseFunc = function(jsonData) {"
    let jsPostfix = "}"

    func parseString(javaScript: String) throws -> String {
        guard javaScript != "" else { return "" }
        let script = "\(jsPrefix) \(javaScript) \(jsPostfix)"
        let context = JSContext()!
        context.evaluateScript(script)
        let parseFunc = context.objectForKeyedSubscript("parseFunc")!
        let parseResult = parseFunc.call(withArguments: [])?.toString() ?? ""
        if (parseResult == "undefined") { throw ParseError(parseResult) }
        return parseResult
    }
}

struct ParseError: Error {
    var msg: String
    var localizedDescription: String { return msg }
    init(_ msg: String) { self.msg = msg }
}
