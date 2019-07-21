//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public extension Swinject {
    init(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(builder()))
    }

    init(@SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([builder()]))
    }

    init(@SwinjectTreeBuilder _: () -> Void) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([]))
    }
}
