//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SwinjectTree {
    
}

public protocol SwinjectEntry {}

@_functionBuilder
public enum SwinjectTreeBuilder {
    public static func buildBlock() -> Void {}

    public static func buildBlock(_ input: SwinjectEntry ...) -> [SwinjectEntry] {
        input.flatMap(unpack)
    }

    public static func buildIf(_ input: [SwinjectEntry]?) -> SwinjectEntry {
        Composed(parts: input ?? [])
    }

    public static func buildEither(first input: [SwinjectEntry]) -> SwinjectEntry {
        Composed(parts: input)
    }

    public static func buildEither(second input: [SwinjectEntry]) -> SwinjectEntry {
        Composed(parts: input)
    }
}

extension SwinjectTreeBuilder {
    private struct Composed: SwinjectEntry {
        let parts: [SwinjectEntry]
    }

    private static func unpack(entry: SwinjectEntry) -> [SwinjectEntry] {
        if let entry = entry as? Composed { return entry.parts } else { return [entry] }
    }
}
