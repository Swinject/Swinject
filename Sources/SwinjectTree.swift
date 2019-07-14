//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol SwinjectEntry {}

public struct SwinjectTree {
    let bindingEntries: [AnyBindingEntry]
    let includeEntries: [ModuleIncludeEntry]
}

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

    // This is not used by compiler implicitly yet
    public static func buildFunction(_ input: [SwinjectEntry]) -> SwinjectTree {
        let entries = input.flatMap(unpack)
        return SwinjectTree(
            bindingEntries: entries.compactMap { $0 as? AnyBindingEntry },
            includeEntries: entries.compactMap { $0 as? ModuleIncludeEntry }
        )
        // TODO: Validate
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
