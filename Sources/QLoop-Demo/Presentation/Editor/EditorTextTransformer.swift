
typealias EditorTextTransform = (((String?), (String?)->()) ->())

func EditorTextTransformer() -> EditorTextTransform {
    return ({ input, completion in
        let transformed: String = "### \(input ?? "") ###"
        completion(transformed)
    })
}
