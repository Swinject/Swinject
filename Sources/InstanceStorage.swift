//
//  InstanceStorage.swift
//  Swinject
//
//  Created by Jakub Vaňo on 11/11/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

/// Storage provided by `ObjectScope`. It is used by `Container` to persist resolved instances.
public protocol InstanceStorage: AnyObject {
    var instance: Any? { get set }
    func graphResolutionCompleted()
}

extension InstanceStorage {
    public func graphResolutionCompleted() {}
}

/// Persists storage during the resolution of the object graph
public final class GraphStorage: InstanceStorage {
    public var instance: Any?

    public init() {}

    public func graphResolutionCompleted() {
        instance = nil
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
        set {}
    }

    public init() {}
}

/// Does not persist value types.
/// Persists reference types as long as there are strong references to given instance.
public final class WeakStorage: InstanceStorage {
    private weak var object: AnyObject?

    #if os(Linux)
    public var instance: Any? {
        get { return object }
        set { object = newValue.flatMap { $0 as? AnyObject } }
    }
    #else
    public var instance: Any? {
        get { return object }
        set { object = newValue as AnyObject? }
    }
    #endif

    public init () {}
}

/// Combines the behavior of multiple instance storages.
/// Instance is persisted as long as at least one of the underlying storages is persisting it.
public final class CompositeStorage: InstanceStorage {
    private let components: [InstanceStorage]

    public var instance: Any? {
        get { return components.flatMap { $0.instance } .first }
        set { components.forEach { $0.instance = newValue } }
    }

    public init(_ components: [InstanceStorage]) {
        self.components = components
    }

    public func graphResolutionCompleted() {
        components.forEach { $0.graphResolutionCompleted() }
    }
}
