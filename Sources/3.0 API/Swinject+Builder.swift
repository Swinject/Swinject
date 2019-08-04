//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public extension Swinject {
    init(
        allowsSilentOverride: Bool = false,
        detectsCircularDependencies: Bool = true,
        _ entries: SwinjectEntry ...
    ) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(entries), properties: Properties(
            allowsSilentOverride: allowsSilentOverride,
            detectsCircularDependencies: detectsCircularDependencies
        ))
    }
}

public extension Swinject { #if swift(>=5.1)
    init(
        allowsSilentOverride: Bool = false,
        detectsCircularDependencies: Bool = true,
        @SwinjectTreeBuilder builder: () -> [SwinjectEntry]
    ) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(builder()), properties: Properties(
            allowsSilentOverride: allowsSilentOverride,
            detectsCircularDependencies: detectsCircularDependencies
        ))
    }

    init(
        allowsSilentOverride: Bool = false,
        detectsCircularDependencies: Bool = true,
        @SwinjectTreeBuilder builder: () -> SwinjectEntry
    ) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([builder()]), properties: Properties(
            allowsSilentOverride: allowsSilentOverride,
            detectsCircularDependencies: detectsCircularDependencies
        ))
    }

    init(
        allowsSilentOverride: Bool = false,
        detectsCircularDependencies: Bool = true,
        @SwinjectTreeBuilder _: () -> Void
    ) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([]), properties: Properties(
            allowsSilentOverride: allowsSilentOverride,
            detectsCircularDependencies: detectsCircularDependencies
        ))
    }
#endif
}

public extension Swinject.Module {
    init(_ name: String, allowsSilentOverride: Bool = false, _ entries: SwinjectEntry ...) {
        self.init(
            name: name,
            tree: SwinjectTreeBuilder.buildFunction(entries),
            allowsSilentOverride: allowsSilentOverride
        )
    }
}

public extension Swinject.Module { #if swift(>=5.1)
    init(_ name: String, allowsSilentOverride: Bool = false, @SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(
            name: name,
            tree: SwinjectTreeBuilder.buildFunction(builder()),
            allowsSilentOverride: allowsSilentOverride
        )
    }

    init(_ name: String, allowsSilentOverride: Bool = false, @SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(
            name: name,
            tree: SwinjectTreeBuilder.buildFunction([builder()]),
            allowsSilentOverride: allowsSilentOverride
        )
    }

    init(_ name: String, allowsSilentOverride: Bool = false, @SwinjectTreeBuilder _: () -> Void) {
        self.init(
            name: name,
            tree: SwinjectTreeBuilder.buildFunction([]),
            allowsSilentOverride: allowsSilentOverride
        )
    }
#endif
}
