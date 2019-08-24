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

public struct Binding<Instance, Context> {
    var products: [TypeDescriptor]
    var dependencies: BindingDependencies
    var factory: (ContextedResolver<Context>, Any) throws -> Instance
    var properties: BindingProperties
    let scope: AnyScope?
    let argumentType: Any.Type
}

extension Binding: AnyBinding {
    public var keys: [BindingKey] {
        return products.map { BindingKey(descriptor: $0, contextType: Context.self, argumentType: argumentType) }
    }

    public var overrides: Bool { return properties.overrides }

    public func makeInstance(resolver: Resolver, arg: Any) throws -> Any {
        if let scope = scope {
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
        return try factory(resolver.contexted(), arg)
    }
}

extension Binding {
    func updated(_ update: (inout Binding<Instance, Context>) -> Void) -> Binding<Instance, Context> {
        var copy = self
        update(&copy)
        return copy
    }

    func updatedFactory<NewInstance, NewArgument>(
        factory: @escaping (ContextedResolver<Context>, NewArgument) throws -> NewInstance
    ) -> Binding<NewInstance, Context> {
        return Binding<NewInstance, Context>(
            products: products,
            dependencies: dependencies,
            factory: { try factory($0, $1 as! NewArgument) },
            properties: properties,
            scope: scope,
            argumentType: NewArgument.self
        )
    }
}
