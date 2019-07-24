//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

/// The `Container` class represents a dependency injection container, which stores registrations of services
/// and retrieves registered services with dependencies injected.
///
/// **Example to register:**
///
///     let container = Container()
///     container.register(A.self) { _ in B() }
///     container.register(X.self) { r in Y(a: r.resolve(A.self)!) }
///
/// **Example to retrieve:**
///
///     let x = container.resolve(X.self)!
///
/// where `A` and `X` are protocols, `B` is a type conforming `A`, and `Y` is a type conforming `X`
/// and depending on `A`.
public final class Container {
    let registry: ScopeRegistry
    let parent: Container?
    let defaultScope: AnyScope?
    var bindings = [Binding]()
    var behaviors = [Behavior]()
    var swinject: Swinject { Swinject(tree: SwinjectTree(
        bindings: allBindings,
        includeEntries: [],
        translators: [registerContextTranslator(from: Graph.self) { $0.container }]
    )) }
    var allBindings: [Binding] {
        return bindings + (parent?.allBindings ?? [])
    }

    /// Instantiates a `Container`
    ///
    /// - Parameters
    ///     - parent: The optional parent `Container`.
    ///     - defaultScope: Default  scope
    ///     - behaviors: List of behaviors to be added to the container
    ///     - registeringClosure: The closure registering services to the new container instance.
    ///
    /// - Remark: Compile time may be long if you pass a long closure to this initializer.
    ///           Use `init()` or `init(parent:)` instead.
    public init(
        parent: Container? = nil,
        defaultScope: AnyScope?,
        behaviors: [Behavior] = [],
        registeringClosure: (Container) -> Void = { _ in }
    ) {
        self.parent = parent
        self.defaultScope = defaultScope
        self.behaviors = behaviors
        registry = parent?.registry ?? StandardScopeRegistry()
        registeringClosure(self)
    }

    /// Instantiates a `Container`
    ///
    /// - Parameters
    ///     - parent: The optional parent `Container`.
    ///     - defaultObjectScope: Default object scope (graph if no scope is injected)
    ///     - behaviors: List of behaviors to be added to the container
    ///     - registeringClosure: The closure registering services to the new container instance.
    ///
    /// - Remark: Compile time may be long if you pass a long closure to this initializer.
    ///           Use `init()` or `init(parent:)` instead.
    public convenience init(
        parent: Container? = nil,
        defaultObjectScope: ObjectScope = .graph,
        behaviors: [Behavior] = [],
        registeringClosure: (Container) -> Void = { _ in }
    ) {
        self.init(
            parent: parent,
            defaultScope: defaultObjectScope.scope,
            behaviors: behaviors,
            registeringClosure: registeringClosure
        )
    }

    /// Removes all registrations in the container.
    public func removeAll() {
        bindings = []
    }

    /// Discards instances for services registered in the given `ObjectsScopeProtocol`.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(ObjectScope.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScopeProtocol` will be discarded.
    public func resetObjectScope(_ objectScope: ObjectScope) {
        (objectScope.scope as? Closable)?.close()
    }

    /// Returns a synchronized view of the container for thread safety.
    /// The returned container is `Resolver` type. Call this method after you finish all service registrations
    /// to the original container.
    ///
    /// - Returns: A synchronized container as `Resolver`.
    public func synchronize() -> Resolver {
        self
    }

    /// Adds behavior to the container. `Behavior.container(_:didRegisterService:withName:)` will be invoked for
    /// each service registered to the `container` **after** the behavior has been added.
    ///
    /// - Parameters:
    ///     - behavior: Behavior to be added to the container
    public func addBehavior(_ behavior: Behavior) {
        behaviors.append(behavior)
    }

    func addEntry<Service>(_ entry: ServiceEntry<Service>, with name: String?) {
        bindings.append(entry)
        behaviors.forEach {
            $0.container(self, didRegisterType: Service.self, toService: entry, withName: name)
        }
    }
}

// MARK: CustomStringConvertible

extension Container: CustomStringConvertible {
    public var description: String {
        ""
    }
}

// MARK: Resolver

extension Container: Resolver {
    public func resolve<Descriptor, Argument>(
        _ request: InstanceRequest<Descriptor, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try swinject.on(Graph(on: self)).resolve(request)
    }
}
