//
//  ObjectScope.Standard.swift
//  Swinject
//
//  Created by Jakub Vaňo on 11/11/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

// TODO: doc
extension ObjectScope {
    public static let none = ObjectScope(storageFactory: TransientStorage.init, description: "none")
    public static let graph = ObjectScope(storageFactory: PermanentStorage.init, description: "graph")
    // TODO: possibly rename to `hierarchy`, as it has the same semantics as old `hierarchy`
    public static let container = ObjectScope(storageFactory: PermanentStorage.init, description: "container")
}
