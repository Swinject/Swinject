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
    struct Resolution {
        let binding: Binding
        let translator: AnyContextTranslator
    }

    public func resolve<Descriptor, Argument>(
        _ request: InstanceRequest<Descriptor, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try instance(
            resolution: findResolution(for: request.descriptor, and: Argument.self),
            context: context,
            arg: request.argument
        )
    }

    private func findResolution(for descriptor: AnyTypeDescriptor, and argumentType: Any.Type) throws -> Resolution {
        let translators = (tree.translators + [IdentityTranslator(for: contextType)]).filter {
            $0.sourceType == contextType
        }
        let keys = translators.map {
            BindingKey(descriptor: descriptor, contextType: $0.targetType, argumentType: argumentType)
        }
        let bindings = keys.map {
            try? findBinding(for: $0)
        }
        let resolutions = zip(bindings, translators)
            .filter { $0.0 != nil }
            .map { Resolution(binding: $0.0!, translator: $0.1) }

        guard resolutions.count == 1 else { throw SwinjectError() }
        return resolutions[0]
    }

    private func findBinding(for key: AnyBindingKey) throws -> Binding {
        let bindings = tree.bindings.filter { $0.matches(key) }
        guard bindings.count == 1 else { throw SwinjectError() }
        return bindings[0]
    }

    private func instance<Type, Context, Argument>(
        resolution: Resolution, context: Context, arg: Argument
    ) throws -> Type {
        try resolution.binding.instance(
            arg: arg,
            context: resolution.translator.translate(context),
            resolver: self
        ) as? Type ?? { throw SwinjectError() }()
    }
}
