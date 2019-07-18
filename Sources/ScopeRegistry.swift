//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

public protocol ScopeRegistry {
    func instance(for key: ScopeRegistryKey, builder: () throws -> Any) rethrows -> Any
}

public class StandardScopeRegistry: ScopeRegistry, Closable {
    private let lock = NSRecursiveLock()
    private var instances = [ScopeRegistryKey: Any]()

    public func instance(for key: ScopeRegistryKey, builder: () throws -> Any) rethrows -> Any {
        try lock.sync {
            if let instance = instances[key] {
                return instance
            } else {
                let newInstance = try builder()
                instances[key] = newInstance
                return newInstance
            }
        }
    }

    public func close() {
        lock.sync {
            instances.values.forEach { ($0 as? Closable)?.close() }
            instances.removeAll()
        }
    }

    deinit {
        close()
    }
}

extension NSLocking {
    func sync<T>(_ action: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try action()
    }
}
