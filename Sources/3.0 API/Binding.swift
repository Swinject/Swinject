//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingProperties {
    public var overrides: Bool
    public var reference: ReferenceMaker<Any>

    static let `default` = BindingProperties(overrides: false, reference: strongRef)
}

enum BindingDependencies {
    case undefined
    case requests([ValueRequest])

    static let none = BindingDependencies.requests([])
}

public struct Binding<Instance, AScope, Context, Argument> {
    var products: [TypeDescriptor]
    var dependencies: BindingDependencies
    var factory: (ContextedResolver<Context>, Argument) throws -> Instance
    var properties: BindingProperties
    var scope: AScope
}

extension Binding {
    var keys: [BindingKey] {
        return products.map { BindingKey(descriptor: $0, contextType: Context.self, argumentType: Argument.self) }
    }
}

extension Binding: AnyBinding {
    public var key: BindingKey { return keys.first! } // FIXME: enable multiple keys in AnyBinding
    public var overrides: Bool { return properties.overrides }
}

extension Binding {
    public func instance(arg: Any, resolver: Resolver) throws -> Any {
        if let scope = scope as? AnyScope {
            return try scopedInstance(resolver: resolver, scope: scope, arg: arg)
        } else {
            return try simpleInstance(resolver: resolver, arg: arg)
        }
    }

    private func scopedInstance(resolver: Resolver, scope: AnyScope, arg: Any) throws -> Any {
        return try scope
            .registry(for: resolver.context(as: Context.self))
            .instance(for: ScopeRegistryKey(descriptor: products.first!, argument: arg)) {
                try properties.reference(simpleInstance(resolver: resolver, arg: arg))
            }
    }

    private func simpleInstance(resolver: Resolver, arg: Any) throws -> Any {
        return try factory(resolver.contexted(), arg as! Argument)
    }
}

extension Binding {
    func updated(_ update: (inout Self) -> Void) -> Self {
        var copy = self
        update(&copy)
        return copy
    }

    func updatedFactory<NewInstance, NewArgument>(
        factory: @escaping (ContextedResolver<Context>, NewArgument) throws -> NewInstance
    ) -> Binding<NewInstance, AScope, Context, NewArgument> {
        return Binding<NewInstance, AScope, Context, NewArgument>(
            products: products, dependencies: dependencies, factory: factory, properties: properties, scope: scope
        )
    }
}
