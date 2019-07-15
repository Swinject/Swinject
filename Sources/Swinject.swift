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

    init(@SwinjectTreeBuilder _: () -> Void) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([]))
    }
}

extension Swinject: Injector {
    public func instance<Descriptor>(_ descriptor: Descriptor) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try instance(from: findBinding(for: descriptor))
    }

    public func provider<Descriptor>(_ descriptor: Descriptor) throws -> () throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        let binding = try findBinding(for: descriptor)
        return { try self.instance(from: binding) }
    }

    private func findBinding(for descriptor: AnyTypeDescriptor) throws -> AnyBinding {
        let entries = tree.bindingEntries.filter { $0.descriptor.matches(descriptor) }
        guard entries.count == 1 else { throw SwinjectError() }
        return entries[0].binding
    }

    private func instance<Type>(from binding: AnyBinding) throws -> Type {
        try binding.instance(using: self) as? Type ?? { throw SwinjectError() }()
    }
}
