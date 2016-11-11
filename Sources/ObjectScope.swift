//
//  ObjectScope.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

// TODO: doc
public protocol ObjectScopeType: AnyObject {
    func makeStorage() -> InstanceStorage
}

public class ObjectScope: ObjectScopeType, CustomStringConvertible {

    public private(set) var description: String
    private var storageFactory: () -> InstanceStorage

    public init(
        storageFactory: @escaping () -> InstanceStorage,
        description: String = ""
    ) {
        self.storageFactory = storageFactory
        self.description = description
    }

    public func makeStorage() -> InstanceStorage {
        return storageFactory()
    }
}
