//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    struct Properties {
        let allowsSilentOverride: Bool
        let detectsCircularDependencies: Bool
    }

    let tree: SwinjectTree
    let container: SwinjectContainer
    let anyContext: Any
    let contextType: Any.Type
    let stack: [AnyInstanceRequest]
    let properties: Properties
}

extension Swinject: Resolver {
    public func resolve<Type>(_ request: InstanceRequest<Type>) throws -> Type {
        let binding: AnyBinding
        do {
            binding = try findBinding(for: request)
        } catch let error as NoBinding {
            if let custom = resolve(request, asCustom: Type.self) { return custom }
            throw error
        }
        return try tracking(request).makeInstance(from: binding, arg: request.argument)
    }

    public func on<Context>(_ context: Context) -> Resolver {
        return with(context: context, contextType: unwrapOptionals(Context.self))
    }

    public func context(as resultType: Any.Type) throws -> Any {
        return try allTranslators
            .filter { $0.sourceType == contextType && $0.targetType == resultType }
            .compactMap { try $0.translate(anyContext) }
            .first ?? { throw NoContextTranslator() }()
    }
}

extension Swinject {
    private func resolve<Type>(_ request: InstanceRequest<Type>, asCustom _: Type.Type) -> Type? {
        guard let custom = Type.self as? CustomResolvable.Type else { return nil }
        if let request = custom.requiredRequest(for: request), !hasBinding(for: request) { return nil }
        // TODO: We should reset tracking only for "delayed" custom resolutions
        return custom.init(resolver: with(stack: []), request: request) as? Type
    }

    private func tracking(_ request: AnyInstanceRequest) throws -> Swinject {
        guard properties.detectsCircularDependencies else { return self }
        guard !stack.contains(where: { request.matches($0) }) else { throw CircularDependency() }
        return with(stack: stack + [request])
    }

    private func translatableKeys(for request: AnyInstanceRequest) -> [BindingKey] {
        return allTranslators.map { request.key(forContextType: $0.targetType) }
    }

    private var allTranslators: [AnyContextTranslator] {
        return container.translators.filter { $0.sourceType == contextType } + defaultTranslators
    }

    private var defaultTranslators: [AnyContextTranslator] {
        return [IdentityTranslator(for: contextType), ToAnyTranslator(for: contextType)]
    }

    private func hasBinding(for request: AnyInstanceRequest) -> Bool {
        return (try? findBinding(for: request)) != nil
    }

    private func findBinding(for request: AnyInstanceRequest) throws -> AnyBinding {
        let bindings = translatableKeys(for: request).compactMap { container.bindings[$0] }
        if bindings.isEmpty { throw NoBinding() }
        if bindings.count > 1 { throw MultipleBindings() }
        return bindings[0]
    }

    private func makeInstance<Type, Argument>(from binding: AnyBinding, arg: Argument) throws -> Type {
        return try binding.instance(arg: arg, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}

extension Swinject {
    init(tree: SwinjectTree, properties: Properties) {
        self.init(
            tree: tree,
            container: SwinjectContainer.Builder(tree: tree, properties: properties).makeContainer(),
            anyContext: (),
            contextType: Void.self,
            stack: [],
            properties: properties
        )
    }

    func with(
        context: Any? = nil,
        contextType: Any.Type? = nil,
        stack: [AnyInstanceRequest]? = nil
    ) -> Swinject {
        return Swinject(
            tree: tree,
            container: container,
            anyContext: context ?? anyContext,
            contextType: contextType ?? self.contextType,
            stack: stack ?? self.stack,
            properties: properties
        )
    }
}
