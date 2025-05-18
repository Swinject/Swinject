//
//  Copyright © 2025 Swinject Contributors. All rights reserved.
//
import Foundation

internal final actor ThreadSafeDictionary<KeyType: Hashable, ValueType> {
    private var internalDictionary = [KeyType: ValueType]()

    // MARK: - Initializers

    public init(dictionary: [KeyType: ValueType]? = nil) {
        if let dictionary = dictionary {
            self.internalDictionary = dictionary
        }
    }

    // MARK: - Functions

    public subscript(key: KeyType) -> ValueType? {
        get { internalDictionary[key] }
        set { internalDictionary[key] = newValue }
    }
    
    public subscript(key: KeyType, default defaultValue: @autoclosure () -> ValueType) -> ValueType {
        get { internalDictionary[key, default: defaultValue()] }
        set { internalDictionary[key] = newValue }
    }

    public func forEach(_ block: ((key: KeyType, value: ValueType)) -> Void) {
        internalDictionary.forEach(block)
    }
    
    public func map<T>(_ transform: ((key: KeyType, value: ValueType)) throws -> T) rethrows -> [T] {
        try internalDictionary.map(transform)
    }

    public func removeAll() {
        internalDictionary.removeAll()
    }
}
