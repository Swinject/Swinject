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
