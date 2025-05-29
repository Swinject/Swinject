//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// Storage provided by ``ObjectScope``. It is used by ``Container`` to persist resolved instances.
public protocol InstanceStorage: AnyObject {
    var instance: Any? { get set }
    func graphResolutionCompleted()
    func instance(inGraph graph: GraphIdentifier) -> Any?
    func setInstance(_ instance: Any?, inGraph graph: GraphIdentifier)

    // New methods for multiton support - default implementations maintain backward compatibility
    func instance(inGraph graph: GraphIdentifier, withArguments arguments: Any?) -> Any?
    func setInstance(_ instance: Any?, inGraph graph: GraphIdentifier, withArguments arguments: Any?)
}

extension InstanceStorage {
    public func graphResolutionCompleted() {}
    public func instance(inGraph _: GraphIdentifier) -> Any? { return instance }
    public func setInstance(_ instance: Any?, inGraph _: GraphIdentifier) { self.instance = instance }

    // Default implementations that ignore arguments for backward compatibility
    public func instance(inGraph graph: GraphIdentifier, withArguments _: Any?) -> Any? {
        return instance(inGraph: graph)
    }

    public func setInstance(_ instance: Any?, inGraph graph: GraphIdentifier, withArguments _: Any?) {
        setInstance(instance, inGraph: graph)
    }
}

/// Persists storage during the resolution of the object graph
public final class GraphStorage: InstanceStorage {
    private var instances = [GraphIdentifier: Weak<Any>]()
    public var instance: Any?

    public init() {}

    public func graphResolutionCompleted() {
        instance = nil
    }

    public func instance(inGraph graph: GraphIdentifier) -> Any? {
        return instances[graph]?.value
    }

    public func setInstance(_ instance: Any?, inGraph graph: GraphIdentifier) {
        self.instance = instance

        if instances[graph] == nil { instances[graph] = Weak() }
        instances[graph]?.value = instance
    }
}

/// Persists stored instance until it is explicitly discarded.
public final class PermanentStorage: InstanceStorage {
    public var instance: Any?

    public init() {}
}

/// Does not persist stored instance.
public final class TransientStorage: InstanceStorage {
    public var instance: Any? {
        get { return nil }
        set {} // swiftlint:disable:this unused_setter_value
    }

    public init() {}
}

/// Does not persist value types.
/// Persists reference types as long as there are strong references to given instance.
public final class WeakStorage: InstanceStorage {
    private var _instance = Weak<Any>()

    public var instance: Any? {
        get { return _instance.value }
        set { _instance.value = newValue }
    }

    public init() {}
}

/// Combines the behavior of multiple instance storages.
/// Instance is persisted as long as at least one of the underlying storages is persisting it.
public final class CompositeStorage: InstanceStorage {
    private let components: [InstanceStorage]

    public var instance: Any? {
        get {
            #if swift(>=4.1)
                return components.compactMap { $0.instance }.first
            #else
                return components.flatMap { $0.instance }.first
            #endif
        }
        set { components.forEach { $0.instance = newValue } }
    }

    public init(_ components: [InstanceStorage]) {
        self.components = components
    }

    public func graphResolutionCompleted() {
        components.forEach { $0.graphResolutionCompleted() }
    }

    public func setInstance(_ instance: Any?, inGraph graph: GraphIdentifier) {
        components.forEach { $0.setInstance(instance, inGraph: graph) }
    }

    public func instance(inGraph graph: GraphIdentifier) -> Any? {
        #if swift(>=4.1)
            return components.compactMap { $0.instance(inGraph: graph) }.first
        #else
            return components.flatMap { $0.instance(inGraph: graph) }.first
        #endif
    }
}

/// Persists instances keyed by their arguments. Requires arguments to be Hashable.
/// Used for multiton pattern where same arguments return same instance.
public final class MultitonStorage: InstanceStorage {
    private var instances = [AnyHashable: Any]()

    public var instance: Any? {
        get { return nil } // Multiton requires arguments
        set {
            // When set to nil, clear all instances (used by resetObjectScope)
            if newValue == nil {
                instances.removeAll()
            }
            // Otherwise, multiton requires arguments
        }
    }

    public init() {}

    public func instance(inGraph _: GraphIdentifier, withArguments arguments: Any?) -> Any? {
        guard let hashableArgs = convertToHashable(arguments) else { return nil }
        return instances[hashableArgs]
    }

    public func setInstance(_ instance: Any?, inGraph _: GraphIdentifier, withArguments arguments: Any?) {
        guard let hashableArgs = convertToHashable(arguments) else { return }
        if let instance = instance {
            instances[hashableArgs] = instance
        } else {
            instances.removeValue(forKey: hashableArgs)
        }
    }

    private func convertToHashable(_ arguments: Any?) -> AnyHashable? {
        // Handle nil arguments (no arguments case) - use a special sentinel value
        guard let arguments = arguments else {
            return "__swinject_no_args__" as AnyHashable
        }

        // Handle different argument types
        if let hashable = arguments as? AnyHashable {
            return hashable
        }

        // For tuples, we need to create a hashable representation
        // This is a simplified approach - in practice we might need more sophisticated handling
        let mirror = Mirror(reflecting: arguments)
        if mirror.displayStyle == .tuple {
            var hasher = Hasher()
            for child in mirror.children {
                if let hashableChild = child.value as? AnyHashable {
                    hashableChild.hash(into: &hasher)
                } else {
                    // If any component is not hashable, we can't use multiton
                    return nil
                }
            }
            return hasher.finalize()
        }

        return nil
    }
}

private class Weak<Wrapped> {
    private weak var object: AnyObject?

    #if os(Linux)
        var value: Wrapped? {
            get {
                guard let object = object else { return nil }
                return object as? Wrapped
            }
            set { object = newValue.flatMap { $0 as? AnyObject } }
        }

    #else
        var value: Wrapped? {
            get {
                guard let object = object else { return nil }
                return object as? Wrapped
            }
            set { object = newValue as AnyObject? }
        }
    #endif
}
