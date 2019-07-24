//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

public protocol ScopeRegistry {
    func instance(
        for key: ScopeRegistryKey,
        builder: () throws -> Reference<Any>,
        finalizer: (Any) throws -> Void
    ) rethrows -> Any
    func clear()
}

extension ScopeRegistry {
    func instance(for key: ScopeRegistryKey, builder: () throws -> Reference<Any>) rethrows -> Any {
        try instance(for: key, builder: builder, finalizer: { _ in })
    }
}

public class StandardScopeRegistry: ScopeRegistry, Closable {
    private let lock = NSRecursiveLock()
    private var instances = [ScopeRegistryKey: () -> Any?]()

    public init() {}

    public func instance(
        for key: ScopeRegistryKey,
        builder: () throws -> Reference<Any>,
        finalizer: (Any) throws -> Void
    ) rethrows -> Any {
        try lock.sync {
            if let instance = instances[key]?() { return instance }
            let ref = try builder()
            if let instance = instances[key]?() { return instance }
            instances[key] = ref.nextValue
            try finalizer(ref.currentValue)
            return ref.currentValue
        }
    }

    public func close() {
        lock.sync {
            instances.values.forEach { ($0() as? Closable)?.close() }
            instances.removeAll()
        }
    }

    public func clear() { close() }

    deinit { close() }
}

extension NSLocking {
    func sync<T>(_ action: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try action()
    }
}
