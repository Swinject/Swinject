//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public extension Swinject {
    init(allowsSilentOverride: Bool = false, _ entries: SwinjectEntry ...) {
        self.init(
            tree: SwinjectTreeBuilder.buildFunction(entries),
            allowsSilentOverride: allowsSilentOverride
        )
    }
}

public extension Swinject { #if swift(>=5.1)
    init(allowsSilentOverride: Bool = false, @SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(
            tree: SwinjectTreeBuilder.buildFunction(builder()),
            allowsSilentOverride: allowsSilentOverride
        )
    }

    init(allowsSilentOverride: Bool = false, @SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(
            tree: SwinjectTreeBuilder.buildFunction([builder()]),
            allowsSilentOverride: allowsSilentOverride
        )
    }

    init(allowsSilentOverride: Bool = false, @SwinjectTreeBuilder _: () -> Void) {
        self.init(
            tree: SwinjectTreeBuilder.buildFunction([]),
            allowsSilentOverride: allowsSilentOverride
        )
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
