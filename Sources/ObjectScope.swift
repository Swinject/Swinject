//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// A configuration how an instance provided by a `Container` is shared in the system.
/// The configuration is ignored if it is applied to a value type.
public protocol ObjectScopeProtocol: AnyObject {
    /// Used to create `InstanceStorage` to persist an instance for single service.
    /// Will be invoked once for each service registered in given scope.
    func makeStorage() -> InstanceStorage
}

/// Basic implementation of `ObjectScopeProtocol`.
public class ObjectScope: ObjectScopeProtocol, CustomStringConvertible {
    public private(set) var description: String
    private var storageFactory: () -> InstanceStorage
    private let parent: ObjectScopeProtocol?

    /// Instantiates an `ObjectScope` with storage factory and description.
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

    /// Will invoke and return the result of `storageFactory` closure provided during initialisation.
    public func makeStorage() -> InstanceStorage {
        if let parent = parent {
            return CompositeStorage([storageFactory(), parent.makeStorage()])
        } else {
            return storageFactory()
        }
    }
}
