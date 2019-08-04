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

extension Swinject: Resolver {
    public func resolve<Type>(_ request: InjectionRequest) throws -> Type {
        let binding: Binding
        do {
            binding = try findBinding(for: request)
        } catch let error as NoBinding {
            if let custom = resolve(request, asCustom: Type.self) { return custom }
            throw error
        }
        return try instance(
            from: binding,
            context: findTranslator(for: binding).translate(context),
            arg: request.argument
        )
    }

    public func on<Context>(_ context: Context) -> Resolver {
        return Swinject(tree: tree, container: container, context: context)
    }

    private func resolve<Type>(_ request: InjectionRequest, asCustom _: Type.Type) -> Type? {
        guard let custom = Type.self as? CustomResolvable.Type else { return nil }
        if let request = custom.requiredRequest(for: request), !hasBinding(for: request) { return nil }
        return custom.init(resolver: self, request: request) as? Type
    }

    private func findTranslator(for binding: Binding) throws -> AnyContextTranslator {
        return try allTranslators
            .filter { binding.key.matches(contextType: $0.targetType) }
            .first ?? { throw NoContextTranslator() }()
    }

    private func translatableKeys(for request: InjectionRequest) -> [BindingKey] {
        return allTranslators.map { request.key(forContextType: $0.targetType) }
    }

    private var allTranslators: [AnyContextTranslator] {
        return container.translators.filter { $0.sourceType == contextType } + defaultTranslators
    }

    private var defaultTranslators: [AnyContextTranslator] {
        return [IdentityTranslator(for: contextType), ToAnyTranslator(for: contextType)]
    }

    private func hasBinding(for request: InjectionRequest) -> Bool {
        return (try? findBinding(for: request)) != nil
    }

    private func findBinding(for request: InjectionRequest) throws -> Binding {
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
