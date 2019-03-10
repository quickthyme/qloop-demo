
typealias TextTransform = ( ((String?), (String?) -> ()) throws ->() )

struct JavaScriptTextTransformer {
    let id: String = "js parser"

    var op: TextTransform {
        return ({ input, completion in
            let parser = JavaScriptParser()
            let result: String =
                try parser.parseString(javaScript: input ?? "")
            completion(result)
        })
    }
}
