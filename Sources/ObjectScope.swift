//
//  ObjectScope.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
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

    /// Instantiates an `ObjectScope` with storage factory and description.
    ///  - Parameters:
    ///     - storageFactory:   Closure for creating an `InstanceStorage`
    ///     - description:      Description of object scope for `CustomStringConvertible` implementation
    public init(
        storageFactory: @escaping () -> InstanceStorage,
        description: String = ""
    ) {
        self.storageFactory = storageFactory
        self.description = description
    }

    /// Will invoke and return the result of `storageFactory` closure provided during initialisation.
    public func makeStorage() -> InstanceStorage {
        return storageFactory()
    }
}
