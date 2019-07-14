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

extension Swinject {
    private func findBindings<Descriptor>(for descriptor: Descriptor) -> [AnyBinding] where Descriptor : TypeDescriptor {
        return tree.bindingEntries
            .filter { $0.descriptor.matches(descriptor) }
            .map { $0.binding }
    }
}

extension Swinject: Injector {
    public func instance<Descriptor, Dependency>(_ descriptor: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        let bindings = findBindings(for: descriptor)
        if bindings.count != 1 {
            throw SwinjectError()
        } else {
            return try bindings[0].instance(using: self) as! Descriptor.BaseType
        }
    }
}
