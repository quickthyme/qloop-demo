
import QLoop

func StubLoopPath<Input, Output>() -> QLoopPath<Input, Output> {
    return QLoopPath<Input, Output>(
        QLoopLinearSegment<Input, Output>("StubLoopSegment", ({ (input, completion) in completion(input as? Output) })))!
}

