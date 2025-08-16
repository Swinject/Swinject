//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// A configuration how an instance provided by a ``Container`` is shared in the system.
/// The configuration is ignored if it is applied to a value type.
public protocol ObjectScopeProtocol: AnyObject {
    /// Used to create `InstanceStorage` to persist an instance for single service.
    /// Will be invoked once for each service registered in given scope.
    func makeStorage() -> InstanceStorage
}

/// Basic implementation of ``ObjectScopeProtocol``.
public final class ObjectScope: ObjectScopeProtocol, CustomStringConvertible, @unchecked Sendable {
    public let description: String
    private let storageFactory: () -> InstanceStorage
    private let parent: ObjectScopeProtocol?

    /// Instantiates an ``ObjectScope`` with storage factory and description.
    ///  - Parameters:
    ///     - storageFactory:   Closure for creating an `InstanceStorage`
    ///     - description:      Description of object scope for `CustomStringConvertible` implementation
    ///     - parent:           If provided, its storage will be composed with the result of `storageFactory`
    public init(
        storageFactory: @escaping () -> InstanceStorage,
        description: String = "",
        parent: ObjectScopeProtocol? = nil
    ) {
        self.storageFactory = storageFactory
        self.description = description
        self.parent = parent
    }

    /// Will invoke and return the result of `storageFactory` closure provided during initialization.
    public func makeStorage() -> InstanceStorage {
        if let parent = parent {
            return CompositeStorage([storageFactory(), parent.makeStorage()])
        } else {
            return storageFactory()
        }
    }
    
    /// A new instance is always created by the ``Container`` when a type is resolved.
    /// The instance is not shared.
    public static let transient = ObjectScope(storageFactory: TransientStorage.init, description: "transient")

    /// Instances are shared only when an object graph is being created,
    /// otherwise a new instance is created by the ``Container``. This is the default scope.
    public static let graph = ObjectScope(storageFactory: GraphStorage.init, description: "graph")

    /// An instance provided by the ``Container`` is shared within the ``Container`` and its child `Containers`.
    public static let container = ObjectScope(storageFactory: PermanentStorage.init, description: "container")

    /// An instance provided by the ``Container`` is shared within the ``Container`` and its child ``Container``s
    /// as long as there are strong references to given instance. Otherwise new instance is created
    /// when resolving the type.
    public static let weak = ObjectScope(storageFactory: WeakStorage.init, description: "weak",
                                         parent: ObjectScope.graph)

}
