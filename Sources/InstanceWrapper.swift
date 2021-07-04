//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol InstanceWrapper {
    static var wrappedType: Any.Type { get }
    init?(inContainer container: Container, withInstanceFactory factory: (() -> Any?)?)
}

/// Wrapper to enable delayed dependency instantiation.
/// `Lazy<Type>` does not need to be explicitly registered into the ``Container`` - resolution will work
/// as long as there is a registration for the `Type`.
public final class Lazy<Service>: InstanceWrapper {
    static var wrappedType: Any.Type { return Service.self }

    private let factory: () -> Any?
    private let graphIdentifier: GraphIdentifier?
    private weak var container: Container?

    init?(inContainer container: Container, withInstanceFactory factory: (() -> Any?)?) {
        guard let factory = factory else { return nil }
        self.factory = factory
        graphIdentifier = container.currentObjectGraph
        self.container = container
    }

    private var _instance: Service?

    /// Getter for the wrapped object.
    /// It will be resolved from the ``Container`` when first accessed, all other calls will return the same instance.
    public var instance: Service {
        if let instance = _instance {
            return instance
        } else {
            _instance = makeInstance()
            return _instance!
        }
    }

    private func makeInstance() -> Service? {
        guard let container = container else {
            return nil
        }
        if let graphIdentifier = graphIdentifier {
            container.restoreObjectGraph(graphIdentifier)
        }
        return factory() as? Service
    }
}

/// Wrapper to enable delayed dependency instantiation.
/// `Provider<Type>` does not need to be explicitly registered into the ``Container`` - resolution will work
/// as long as there is a registration for the `Type`.
public final class Provider<Service>: InstanceWrapper {
    static var wrappedType: Any.Type { return Service.self }

    private let factory: () -> Any?

    init?(inContainer _: Container, withInstanceFactory factory: (() -> Any?)?) {
        guard let factory = factory else { return nil }
        self.factory = factory
    }

    /// Getter for the wrapped object.
    /// New instance will be resolved from the ``Container`` every time it is accessed.
    public var instance: Service {
        return factory() as! Service
    }
}

extension Optional: InstanceWrapper {
    static var wrappedType: Any.Type { return Wrapped.self }

    init?(inContainer _: Container, withInstanceFactory factory: (() -> Any?)?) {
        self = factory?() as? Wrapped
    }
}
