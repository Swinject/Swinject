//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct BindingProperties {
    var overrides: Bool
    var reference: ReferenceMaker<Any>

    static let `default` = BindingProperties(overrides: false, reference: strongRef)
}

enum BindingDependencies {
    case undefined
    case requests([ValueRequest])

    static let none = BindingDependencies.requests([])
}

protocol Binding: AnyBinding {
    associatedtype Instance
    associatedtype AScope
    associatedtype Context
    associatedtype Argument

    var products: [TypeDescriptor] { get }
    var dependencies: BindingDependencies { get }
    var factory: (ContextedResolver<Context>, Argument) throws -> Instance { get }
    var properties: BindingProperties { get }
    var scope: AScope { get }
}

extension Binding {
    var keys: [BindingKey] {
        return products.map { BindingKey(descriptor: $0, contextType: Context.self, argumentType: Argument.self) }
    }

    public var key: BindingKey { return keys.first! } // FIXME: enable multiple keys in AnyBinding
    public var overrides: Bool { return properties.overrides }
}

extension Binding {
    // TODO: swap param order
    public func instance(arg: Any, resolver: Resolver) throws -> Any {
        // TODO: scope handling
        return try factory(resolver.contexted(), arg as! Argument)
    }
}

public struct SomeBinding<Instance, AScope, Context, Argument>: Binding {
    var products: [TypeDescriptor]
    var dependencies: BindingDependencies
    var factory: (ContextedResolver<Context>, Argument) throws -> Instance
    var properties: BindingProperties
    var scope: AScope
}

extension Binding {
    func opaque() -> SomeBinding<Instance, AScope, Context, Argument> {
        return SomeBinding(
            products: products, dependencies: dependencies, factory: factory, properties: properties, scope: scope
        )
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
    ) -> SomeBinding<NewInstance, AScope, Context, NewArgument> {
        return SomeBinding(
            products: products, dependencies: dependencies, factory: factory, properties: properties, scope: scope
        )
    }
}
