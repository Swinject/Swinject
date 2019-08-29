//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Reference<T> {
    let currentValue: T
    let nextValue: () -> T?
}

public typealias ReferenceMaker<T> = (T) -> Reference<T>

public func strongRef<T>(_ value: T) -> Reference<T> {
    return Reference(currentValue: value, nextValue: { value })
}

public func weakRef<T>(_ value: T) -> Reference<T> {
    weak var weakValue: AnyObject? = value as AnyObject?
    return Reference(currentValue: value) {
        if let value = weakValue { return value as? T } else { return nil }
    }
}

func noRef<T>(_ value: T) -> Reference<T> {
    return Reference(currentValue: value, nextValue: { nil })
}
