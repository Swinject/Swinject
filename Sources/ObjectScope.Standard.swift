//
//  ObjectScope.Standard.swift
//  Swinject
//
//  Created by Jakub Vaňo on 11/11/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

extension ObjectScope {
    /// A new instance is always created by the `Container` when a type is resolved.
    /// The instance is not shared.
    public static let transient = ObjectScope(storageFactory: TransientStorage.init, description: "transient")

    /// Instances are shared only when an object graph is being created,
    /// otherwise a new instance is created by the `Container`. This is the default scope.
    public static let graph = ObjectScope(storageFactory: PermanentStorage.init, description: "graph")

    /// An instance provided by the `Container` is shared within the `Container` and its child `Containers`.
    public static let container = ObjectScope(storageFactory: PermanentStorage.init, description: "container")

    /// An instance provided by the `Container` is shared within the `Container` and its child `Container`s 
    /// as long as there are strong references to given instance. Otherwise new instance is created
    /// when resolving the type.
    public static let weak = ObjectScope(storageFactory: WeakStorage.init, description: "weak")
}
