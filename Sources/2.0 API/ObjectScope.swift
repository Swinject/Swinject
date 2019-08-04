//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// A configuration how an instance provided by a `Container` is shared in the system.
/// The configuration is ignored if it is applied to a value type.
public enum ObjectScope: String, CaseIterable {
    /// A new instance is always created by the `Container` when a type is resolved.
    /// The instance is not shared.
    case transient

    /// Instances are shared only when an object graph is being created,
    /// otherwise a new instance is created by the `Container`. This is the default scope.
    case graph

    /// An instance provided by the `Container` is shared within the `Container` and its child `Containers`.
    case container

    /// An instance provided by the `Container` is shared within the `Container` and its child `Container`s
    /// as long as there are strong references to given instance. Otherwise new instance is created
    /// when resolving the type.
    case weak
}

extension ObjectScope {
    var scope: AnyScope? {
        switch self {
        case .graph: return GraphScope.shared
        case .container: return ContainerScope.container
        case .weak: return ContainerScope.weak
        case .transient: return nil
        }
    }

    var makeRef: ReferenceMaker<Any> {
        switch self {
        case .graph: return strongRef
        case .container: return strongRef
        case .weak: return weakRef
        case .transient: return noRef
        }
    }
}

final class Graph {
    let registry = StandardScopeRegistry()
}

final class GraphScope: Scope, CustomStringConvertible {
    static let shared = GraphScope()
    let description = "graph"

    func registry(for graph: Graph) -> ScopeRegistry {
        return graph.registry
    }
}

final class ContainerScope: Scope, CustomStringConvertible {
    static let container = ContainerScope("container")
    static let weak = ContainerScope("weak")

    let description: String

    init(_ description: String) {
        self.description = description
    }

    func registry(for context: Any) -> ScopeRegistry {
        return (context as! Container).registry
    }
}
