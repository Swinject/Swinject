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

extension Swinject: Resolver {
    public func resolve<Descriptor, Context, Argument>(_ request: BindingRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try instance(from: findBinding(for: request.key), context: request.context, arg: request.argument)
    }

    private func findBinding(for key: AnyBindingKey) throws -> AnyBinding {
        let entries = tree.bindingEntries.filter { $0.key.matches(key) }
        guard entries.count == 1 else { throw SwinjectError() }
        return entries[0].binding
    }

    private func instance<Type, Context, Argument>(from binding: AnyBinding, context: Context, arg: Argument) throws -> Type {
        try binding.instance(arg: arg, context: context, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}
