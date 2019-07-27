//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public extension Swinject {
    init(_ entries: SwinjectEntry ...) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(entries))
    }
}

public extension Swinject { #if swift(>=5.1)
    init(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(builder()))
    }

    init(@SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([builder()]))
    }

    init(@SwinjectTreeBuilder _: () -> Void) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([]))
    }
#endif
}

public extension Swinject.Module {
    init(_ name: String, _ entries: SwinjectEntry ...) {
        self.init(name: name, tree: SwinjectTreeBuilder.buildFunction(entries))
    }
}

public extension Swinject.Module { #if swift(>=5.1)
    init(_ name: String, @SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(name: name, tree: SwinjectTreeBuilder.buildFunction(builder()))
    }

    init(_ name: String, @SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(name: name, tree: SwinjectTreeBuilder.buildFunction([builder()]))
    }

    init(_ name: String, @SwinjectTreeBuilder _: () -> Void) {
        self.init(name: name, tree: SwinjectTreeBuilder.buildFunction([]))
    }
#endif
}
