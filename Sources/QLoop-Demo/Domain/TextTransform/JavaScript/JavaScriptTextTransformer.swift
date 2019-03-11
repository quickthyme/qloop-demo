
struct JavaScriptTextTransformer {
    let id: String = "js parser"

    var op: TextTransform {
        return ({ input, completion in
            let parser = JavaScriptParser()
            let result: String =
                parser.parseString(javaScript: input ?? "")
            completion(result)
        })
    }
}
