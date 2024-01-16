//
//  Copyright © 2023 Swinject Contributors. All rights reserved.
//

import Foundation

internal final class ReadWriteLock {
    private var lock: pthread_rwlock_t = pthread_rwlock_t()

    init() {
        pthread_rwlock_init(&lock, nil)
    }

    deinit {
        pthread_rwlock_destroy(&lock)
    }

    @inlinable public func read<T>(_ block: () throws -> T) rethrows -> T {
        pthread_rwlock_rdlock(&lock)
        defer { pthread_rwlock_unlock(&lock) }

        return try block()
    }

    @inlinable public func write<T>(_ block: () throws -> T) rethrows -> T {
        pthread_rwlock_wrlock(&lock)
        defer { pthread_rwlock_unlock(&lock) }

        return try block()
    }
}
