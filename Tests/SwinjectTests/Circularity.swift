//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation
import Swinject

// MARK: Circular dependency of two objects

internal protocol ParentProtocol: AnyObject {}
internal protocol ChildProtocol: AnyObject {}

internal class Parent: ParentProtocol {
    var child: ChildProtocol?

    init() {}

    init(child: ChildProtocol) {
        self.child = child
    }
}

internal class Child: ChildProtocol {
    weak var parent: ParentProtocol?
}

// MARK: - Circular dependency of more than two objects

internal protocol A: AnyObject {}
internal protocol B: AnyObject {}
internal protocol C: AnyObject {}
internal protocol D: AnyObject {}

internal class ADependingOnB: A {
    var b: B?

    init() {}

    init(b: B) {
        self.b = b
    }
}

internal class BDependingOnC: B {
    var c: C?

    init() {}

    init(c: C) {
        self.c = c
    }
}

internal class CDependingOnAD: C {
    weak var a: A?
    var d: D?

    init() {}

    init(d: D) {
        self.d = d
    }
}

internal class DDependingOnBC: D {
    weak var b: B?
    weak var c: C?
}

internal class CDependingOnWeakB: C {
    weak var b: B?
}

internal protocol LazyParentProtocol {
    var child1: LazyChildProtocol { get }
    var child2: LazyChildProtocol { get }
}
internal protocol LazyChildProtocol: AnyObject {
    var lazy: Lazy<LazilyResolvedProtocol> { get }
}
internal protocol LazySingletonProtocol {
    var lazy: Lazy<LazilyResolvedProtocol> { get }
}
internal protocol LazilyResolvedProtocol: AnyObject { }

internal class LazyParent: LazyParentProtocol {
    let child1: LazyChildProtocol
    let child2: LazyChildProtocol

    init(child1: LazyChildProtocol, child2: LazyChildProtocol) {
        self.child1 = child1
        self.child2 = child2
    }
}

internal class LazyChild: LazyChildProtocol, LazySingletonProtocol {
    let lazy: Lazy<LazilyResolvedProtocol>

    init(lazy: Lazy<LazilyResolvedProtocol>) {
        self.lazy = lazy
    }
}

internal class LazilyResolved: LazilyResolvedProtocol { }
