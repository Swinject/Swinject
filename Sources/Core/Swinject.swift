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
            binding = try container.findBinding(for: request.descriptor, on: contextType)
        } catch let error as NoBinding {
            if let custom = customResolve(request) { return custom }
            throw error
        }
        return try tracking(request).makeInstance(from: binding, with: request.arguments)
    }

    public func on<Context>(_ context: Context) -> Resolver {
        return with(context: context, contextType: unwrapOptionals(Context.self))
    }

    public func context(as resultType: Any.Type) throws -> Any {
        return try container.allTranslators(on: contextType)
            .filter { $0.sourceType == contextType && $0.targetType == resultType }
            .compactMap { try $0.translate(anyContext) }
            .first ?? { throw NoContextTranslator() }()
    }
}

extension Swinject {
    private func customResolve<Type>(_ request: InstanceRequest<Type>) -> Type? {
        guard let custom = Type.self as? CustomResolvable.Type else { return nil }
        guard container.hasBinding(for: request.descriptor, on: contextType) else { return nil }
        return custom.init(
            resolver: custom.delaysResolution ? with(stack: []) : self,
            request: request
        ) as? Type
    }

    private func tracking(_ request: AnyInstanceRequest) throws -> Swinject {
        guard properties.detectsCircularDependencies else { return self }
        guard !stack.contains(where: { request.matches($0) }) else { throw CircularDependency() }
        return with(stack: stack + [request])
    }

    private func makeInstance<Type>(from binding: AnyBinding, with arguments: Arguments) throws -> Type {
        return try binding.makeInstance(resolver: self, arguments: arguments) as? Type ?? { throw SwinjectError() }()
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
