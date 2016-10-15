//
//  ObjectScope.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

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

open class ObjectScope {
    public init() {}

    open var name: String { return "" }

    open func objectPool(container: Container) -> ObjectPool {
        fatalError()
    }
}

extension ObjectScope: CustomStringConvertible {
    public var description: String { return name }
}



internal final class NoneObjectScope: ObjectScope {
    override var name: String { return "none" }

    override func objectPool(container: Container) -> ObjectPool {
        return ObjectPool()
    }
}


internal final class GraphObjectScope: ObjectScope {
    override var name: String { return "graph" }

    override func objectPool(container: Container) -> ObjectPool {
        return container.resolutionPool
    }
}


internal final class ContainerObjectScope: ObjectScope {
    override var name: String { return "container" }

    override func objectPool(container: Container) -> ObjectPool {
        return container.containerPool
    }
}

internal final class HierarchyObjectScope: ObjectScope {
    override var name: String { return "hierarchy" }

    override func objectPool(container: Container) -> ObjectPool {
        return root(container).containerPool
    }

    private func root(_ container: Container) -> Container {
        if let parent = container.parent {
            return root(parent)
        } else {
            return container
        }
    }
}


extension ObjectScope {
    public static let none = NoneObjectScope() as ObjectScope
    public static let graph = GraphObjectScope() as ObjectScope
    public static let container = ContainerObjectScope() as ObjectScope
    public static let hierarchy = HierarchyObjectScope() as ObjectScope
}
