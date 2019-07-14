//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let tree: SwinjectTree

    init(tree: SwinjectTree) {
        self.tree = tree
    }
}

public extension Swinject {
    init(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(builder()))
    }

    init(@SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([builder()]))
    }

    init(@SwinjectTreeBuilder builder: () -> Void) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([]))
    }
}

extension Swinject: Injector {
    public func instance<Descriptor>(_ descriptor: Descriptor) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        guard
            let entry = tree.bindingEntries.first,
            entry.descriptor.matches(descriptor)
        else { throw SwinjectError() }
        return try entry.binding.instance(using: NoInjector()) as? Descriptor.BaseType ?? { throw SwinjectError() }()
    }
}

private struct NoInjector: Injector {
    func instance<Descriptor>(_ descriptor: Descriptor) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        fatalError()
    }
}
