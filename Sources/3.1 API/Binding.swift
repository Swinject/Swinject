//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol Binding: AnyBinding {
    associatedtype Instance
    associatedtype AScope
    associatedtype Context
    associatedtype Argument

    var keys: Set<BindingKey> { get }
    var dependencies: [ValueRequest] { get }
    var factory: (Resolver, Context, Argument) throws -> Instance { get }
    var scope: AScope { get }
}

extension Binding {
    public var key: BindingKey { keys.first! } // FIXME: enable multiple keys in AnyBinding
}

extension Binding {
    // TODO: swap param order
    public func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        // TODO: scope handling
        return try factory(resolver, context as! Context, arg as! Argument)
    }
}

public struct SomeBinding<Instance, AScope, Context, Argument>: Binding {
    var keys: Set<BindingKey>
    var dependencies: [ValueRequest]
    var factory: (Resolver, Context, Argument) throws -> Instance
    public var properties: BindingProperties
    var scope: AScope
}

extension Binding {
    func opaque() -> SomeBinding<Instance, AScope, Context, Argument> {
        return SomeBinding(
            keys: keys, dependencies: dependencies, factory: factory, properties: properties, scope: scope
        )
    }
}

extension Binding {
    func updated(_ update: (inout Self) -> Void) -> Self {
        var copy = self
        update(&copy)
        return copy
    }

    func updated<NewInstance, NewArgument>(
        factory: @escaping (Resolver, Context, NewArgument) throws -> NewInstance
    ) -> SomeBinding<NewInstance, AScope, Context, NewArgument> {
        return SomeBinding(
            keys: keys, dependencies: dependencies, factory: factory, properties: properties, scope: scope
        )
    }
}
