//
//  Copyright © 2023 Swinject Contributors. All rights reserved.
//
import Foundation

internal final class ThreadSafeDictionary<KeyType: Hashable, ValueType> {
    private var internalDictionary = [KeyType: ValueType]()

    private let lock = ReadWriteLock()

    // MARK: - Initializers

    public init(dictionary: [KeyType: ValueType]? = nil) {
        if let dictionary = dictionary {
            lock.write {
                self.internalDictionary = dictionary
            }
        }
    }

    // MARK: - Functions

    public subscript(key: KeyType) -> ValueType? {
        get {
            return lock.read { self.internalDictionary[key] }
        }

        set {
            lock.write {
                self.internalDictionary[key] = newValue
            }
        }
    }
    
    public subscript(key: KeyType, default defaultValue: @autoclosure () -> ValueType) -> ValueType? {
        get {
            return lock.read { self.internalDictionary[key, default: defaultValue()] }
        }

        set {
            lock.write {
                self.internalDictionary[key] = newValue
            }
        }
    }

    public func forEachRead(_ block: ((key: KeyType, value: ValueType)) -> Void) {
        lock.read {
            self.internalDictionary.forEach(block)
        }
    }
    
    public func forEachWrite(_ block: ((key: KeyType, value: ValueType)) -> Void) {
        lock.write {
            self.internalDictionary.forEach(block)
        }
    }

    public func map<T>(_ transform: ((key: KeyType, value: ValueType)) throws -> T) rethrows -> [T] {
        try lock.read {
            try self.internalDictionary.map(transform)
        }
    }

    public func removeAll() {
        lock.write {
            self.internalDictionary.removeAll()
        }
    }
}
