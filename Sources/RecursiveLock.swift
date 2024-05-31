//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
/// `os_unfair_lock_recursive` is, for some reason, a private-API.
///
/// `RecursiveLock` is a fair, recursive lock where acquisition order is guaranteed and recursion is permitted.
///
/// Based on readings:
/// - https://www.mikeash.com/pyblog/friday-qa-2017-10-27-locks-thread-safety-and-swift-2017-edition.html
/// - https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Sources/Atomic.swift
/// - https://serhiybutz.medium.com/swift-mutex-benchmark-b21ee293d9ad
///
/// Class-type paired with pointer-use guarantees address stability.
internal final class RecursiveLock {
    // MARK: Lifecycle

    internal init() {
        mutex = .allocate(capacity: 1)
        mutex.initialize(to: pthread_mutex_t())

        let attr = UnsafeMutablePointer<pthread_mutexattr_t>.allocate(capacity: 1)
        attr.initialize(to: pthread_mutexattr_t())
        pthread_mutexattr_init(attr)
        pthread_mutexattr_settype(attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutexattr_setpolicy_np(attr, PTHREAD_MUTEX_POLICY_FIRSTFIT_NP)

        defer {
            pthread_mutexattr_destroy(attr)
            attr.deinitialize(count: 1)
            attr.deallocate()
        }

        pthread_mutex_init(mutex, attr)
    }

    deinit {
        let status = pthread_mutex_destroy(mutex)
        assert(status == 0, "Unlock the lock before destroying it")

        mutex.deinitialize(count: 1)
        mutex.deallocate()
    }

    // MARK: Internal

    internal func lock() {
        let status = pthread_mutex_lock(mutex)
        switch status {
        case 0:
            break
        case EDEADLK:
            fatalError("Lock failed, would cause deadlock")
        default:
            fatalError("Could not lock")
        }
    }

    internal func unlock() {
        let status = pthread_mutex_unlock(mutex)
        switch status {
        case 0:
            break
        case EPERM:
            fatalError("Cannot unlock when another thread owns the lock!")
        default:
            fatalError("Could not unlock")
        }
    }

    // MARK: Private

    private let mutex: UnsafeMutablePointer<pthread_mutex_t>
}
#else
internal final class RecursiveLock {
    private let recursiveLock = NSRecursiveLock()

    func lock() {
        recursiveLock.lock()
    }

    func unlock() {
        recursiveLock.unlock()
    }
}
#endif

extension RecursiveLock {
    /// Guarantee exclusive thread access to certain logic.
    ///
    /// Claims ownership over this lock within the scope of the closure,
    /// during which this thread owns this lock. Nested `atomic` calls
    /// on the same thread are permitted.
    @discardableResult
    func sync<T>(_ block: () throws -> (T)) rethrows -> T {
        lock(); defer { unlock() }
        return try block()
    }
}
