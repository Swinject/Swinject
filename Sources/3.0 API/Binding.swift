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
    case list([PartialDependency])

    static let none = BindingDependencies.list([])
}

public struct Binding<Instance, Context> {
    var products: [TypeDescriptor]
    var dependencies: BindingDependencies
    var factory: (ContextedResolver<Context>, Arguments) throws -> Instance
    var properties: BindingProperties
    let scope: AnyScope?
    var arguments: Arguments.Descriptor
}

extension Binding: AnyBinding {
    public var keys: [BindingKey] {
        return products.map { BindingKey(type: $0, contextType: Context.self, arguments: arguments) }
    }

    public var overrides: Bool { return properties.overrides }

    public func makeInstance(resolver: Resolver, arguments: Arguments) throws -> Any {
        if let scope = scope {
            return try scopedInstance(resolver: resolver, scope: scope, arguments: arguments)
        } else {
            return try simpleInstance(resolver: resolver, arguments: arguments)
        }
    }

    private func scopedInstance(resolver: Resolver, scope: AnyScope, arguments: Arguments) throws -> Any {
        return try scope
            .registry(for: resolver.context(as: Context.self))
            .instance(for: ScopeRegistryKey(descriptor: products.first!, arguments: arguments)) {
                try properties.reference(simpleInstance(resolver: resolver, arguments: arguments))
            }
    }

    private func simpleInstance(resolver: Resolver, arguments: Arguments) throws -> Any {
        return try factory(resolver.contexted(), arguments)
    }
}

extension Binding {
    func updated(_ update: (inout Binding<Instance, Context>) -> Void) -> Binding<Instance, Context> {
        var copy = self
        update(&copy)
        return copy
    }

    func updatedFactory<NewInstance>(
        factory: @escaping (ContextedResolver<Context>, Arguments) throws -> NewInstance
    ) -> Binding<NewInstance, Context> {
        return Binding<NewInstance, Context>(
            products: products,
            dependencies: dependencies,
            factory: factory,
            properties: properties,
            scope: scope,
            arguments: arguments
        )
    }
}
