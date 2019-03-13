
struct GuardNumberText {
    let id: String = "guard number text"

    var op: TextTransform {
        return ({ input, completion in
            guard
                let input = input,
                let _ = Double.init(input)
                else { throw GuardNumberText.NaN() }
            completion(input)
        })
    }

    struct NaN: Swift.Error {}
}

