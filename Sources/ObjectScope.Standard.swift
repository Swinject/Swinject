//
//  ObjectScope.Standard.swift
//  Swinject
//
//  Created by Jakub Vaňo on 15/10/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

extension ObjectScope {
    /// A new instance is always created by the `Container` when a type is resolved.
    /// The instance is not shared. (aka Transient scope.)
    public static let none = NoneObjectScope() as ObjectScope

    /// Instances are shared only when an object graph is being created,
    /// otherwise a new instance is created by the `Container`. This is the default scope.
    public static let graph = GraphObjectScope() as ObjectScope

    /// An instance provided by the `Container` is shared within the `Container`. 
    /// (aka Singleton scope in the `Container`.)
    public static let container = ContainerObjectScope() as ObjectScope

    /// An instance provided by the `Container` is not only shared within the `Container` 
    /// but also shared within its child `Containers`.
    public static let hierarchy = HierarchyObjectScope() as ObjectScope
}

private final class NoneObjectScope: ObjectScope, CustomStringConvertible {
    fileprivate var description = "none"

    override func objectPool(for container: Container) -> ObjectPool {
        return ObjectPool()
    }
}

private final class GraphObjectScope: ObjectScope, CustomStringConvertible {
    fileprivate var description = "graph"

    override func objectPool(for container: Container) -> ObjectPool {
        return container.resolutionPool
    }
}

private final class ContainerObjectScope: ObjectScope, CustomStringConvertible {
    fileprivate var description = "container"

    override func objectPool(for container: Container) -> ObjectPool {
        return container.containerPool
    }
}

private final class HierarchyObjectScope: ObjectScope, CustomStringConvertible {
    fileprivate var description = "hierarchy"

    override func objectPool(for container: Container) -> ObjectPool {
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
