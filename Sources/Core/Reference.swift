//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Reference<T> {
    let currentValue: T
    let nextValue: () -> T?
}

public protocol ReferenceMaker {
    func makeReference<T>(for value: T) -> Reference<T>
}

struct StrongReferenceMaker: ReferenceMaker {
    func makeReference<T>(for value: T) -> Reference<T> {
        Reference(currentValue: value, nextValue: { value })
    }
}

struct WeakReferenceMaker: ReferenceMaker {
    func makeReference<T>(for value: T) -> Reference<T> {
        weak var weakValue: AnyObject? = value as AnyObject?
        return Reference(currentValue: value, nextValue: { weakValue as? T })
    }
}

public let strongRef: ReferenceMaker = StrongReferenceMaker()
public let weakRef: ReferenceMaker = WeakReferenceMaker()
