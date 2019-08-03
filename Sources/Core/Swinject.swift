//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let tree: SwinjectTree
    let container: SwinjectContainer
    let context: Any
    let contextType: Any.Type

    init(tree: SwinjectTree, allowsSilentOverride: Bool) {
        self.init(
            tree: tree,
            container: SwinjectContainer
                .Builder(tree: tree, allowsSilentOverride: allowsSilentOverride)
                .makeContainer(),
            context: ()
        )
    }

    init<Context>(tree: SwinjectTree, container: SwinjectContainer, context: Context) {
        self.tree = tree
        self.container = container
        self.context = context
        contextType = Context.self
    }
}

extension Swinject {
    public func on<Context>(_ context: Context) -> Swinject {
        return Swinject(tree: tree, container: container, context: context)
    }
}

extension Swinject: Resolver {
    public func resolve<Type, Tag, Argument>(_ request: InstanceRequest<Type, Tag, Argument>) throws -> Type {
        var binding: Binding!
        // FIXME: Refactor this
        do {
            binding = try findBinding(for: request)
        } catch let error as NoBinding {
            if let optional = Type.self as? OptionalProtocol.Type {
                return optional.init() as! Type
            }
            if let provider = Type.self as? AnyPropertyWrapper.Type {
                _ = try findBinding(for: provider.transform(request))
                return provider.init(resolver: self, request: request) as! Type
            }
            throw error
        }
        let translator = try findTranslator(for: request, and: binding)
        return try instance(from: binding, context: translator.translate(context), arg: request.argument)
    }

    private func findTranslator(for _: AnyInstanceRequest, and binding: Binding) throws -> AnyContextTranslator {
        return try (container.translators + [IdentityTranslator(for: contextType), ToAnyTranslator(for: contextType)])
            .filter { $0.sourceType == contextType }
            .filter { binding.key.contextType == Any.self || binding.key.contextType == $0.targetType }
            .first ?? { throw SwinjectError() }()
    }

    private func translatableKeys(for request: AnyInstanceRequest) -> [BindingKey] {
        return (container.translators + [IdentityTranslator(for: contextType), ToAnyTranslator(for: contextType)])
            .filter { $0.sourceType == contextType }
            .map { request.key(forContextType: $0.targetType) }
    }

    private func findBinding(for request: AnyInstanceRequest) throws -> Binding {
        let bindings = translatableKeys(for: request).compactMap { container.bindings[$0] }
        if bindings.isEmpty { throw NoBinding() }
        if bindings.count > 1 { throw MultipleBindings() }
        return bindings[0]
    }

    private func instance<Type, Context, Argument>(
        from binding: Binding, context: Context, arg: Argument
    ) throws -> Type {
        return try binding.instance(arg: arg, context: context, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}
