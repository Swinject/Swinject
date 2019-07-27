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
        contextType = Context.self
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
        var binding: Binding!
        // FIXME: Refactor this
        do {
            binding = try findBinding(for: request)
        } catch let error as NoBindingError {
            if let optional = Descriptor.BaseType.self as? OptionalProtocol.Type {
                return optional.init() as! Descriptor.BaseType
            } else {
                throw error
            }
        }
        let translator = try findTranslator(for: request, and: binding)
        return try instance(from: binding, context: translator.translate(context), arg: request.argument)
    }

    private func findTranslator(for request: AnyInstanceRequest, and binding: Binding) throws -> AnyContextTranslator {
        return try (tree.translators + [IdentityTranslator(for: contextType)])
            .filter { $0.sourceType == contextType }
            .filter { binding.matches(request.key(forContextType: $0.targetType)) }
            .first ?? { throw SwinjectError() }()
    }

    private func findBinding(for request: AnyInstanceRequest) throws -> Binding {
        let bindings = tree.allBindings.filter { (try? findTranslator(for: request, and: $0)) != nil }
        if bindings.isEmpty { throw NoBindingError() }
        if bindings.count > 1 { throw MultipleBindingsError() }
        return bindings[0]
    }

    private func instance<Type, Context, Argument>(
        from binding: Binding, context: Context, arg: Argument
    ) throws -> Type {
        return try binding.instance(arg: arg, context: context, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}
