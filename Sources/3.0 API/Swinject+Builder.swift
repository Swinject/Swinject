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
