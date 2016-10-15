//
//  ObjectScope.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

/// A configuration how an instance provided by a `Container` is shared in the system.
/// The configuration is ignored if it is applied to a value type.
open class ObjectScope {
    public init() {}

    /// Used by `Container` to obtain `ObjectPool` during service resolution.
    /// Custom implementations can use this to manage lifetime of provided instances.
    ///
    /// Default implementation always returns a new instance.
    open func objectPool(for container: Container) -> ObjectPool {
        return ObjectPool()
    }
}

/// Storage for instances created by `Container`.
/// Multiple instances can be used by `ObjectScope` to manage lifetime of objects created by `Container`.
public class ObjectPool {
    internal var pool = [ServiceKey: Any]()

    public init() {}

    internal subscript(key: ServiceKey) -> Any? {
        get { return pool[key] }
        set { pool[key] = newValue }
    }

    internal func removeAll() {
        pool = [:]
    }
}
