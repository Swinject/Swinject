//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let tree: SwinjectTree
    let context: Any
    let contextType: Any.Type

    init(tree: SwinjectTree) {
        self.init(tree: tree, context: ())
    }

    init<Context>(tree: SwinjectTree, context: Context) {
        self.tree = tree
        self.context = context
        self.contextType = Context.self
    }
}

extension Swinject {
    public func on<Context>(_ context: Context) -> Swinject {
        return Swinject(tree: tree, context: context)
    }
}

extension Swinject: Resolver {
    public func resolve<Descriptor, Argument>(
        _ request: InstanceRequest<Descriptor, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        let key = BindingKey(
            descriptor: request.descriptor,
            contextType: contextType,
            argumentType: Argument.self
        )
        return try instance(from: findBinding(for: key), context: context, arg: request.argument)
    }

    private func findBinding(for key: AnyBindingKey) throws -> Binding {
        let bindings = tree.bindings.filter { $0.matches(key) }
        guard bindings.count == 1 else { throw SwinjectError() }
        return bindings[0]
    }

    private func instance<Type, Context, Argument>(
        from binding: Binding, context: Context, arg: Argument
    ) throws -> Type {
        try binding.instance(arg: arg, context: context, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}
