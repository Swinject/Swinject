//
//  InstanceStorage.swift
//  Swinject
//
//  Created by Jakub Vaňo on 11/11/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

// TODO: doc
public protocol InstanceStorage: AnyObject {
    var instance: Any? { get set }
}

public final class PermanentStorage: InstanceStorage {
    public var instance: Any?

    public init() {}
}

public final class TransientStorage: InstanceStorage {
    public var instance: Any? {
        get { return nil }
        set {}
    }

    public init() {}
}
