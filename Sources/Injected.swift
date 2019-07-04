//
//  Injected.swift
//  Swinject-iOS
//
//  Created by Jakub Vano on 04/07/2019.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

var implicitResolver: Resolver?

@propertyWrapper
public struct Injected<T> {
    public let wrappedValue: T

    public init() {
        wrappedValue = implicitResolver!.resolve(T.self)!
    }

    public init(name: String) {
        wrappedValue = implicitResolver!.resolve(T.self, name: name)!
    }

    public init<A1>(argument: A1) {
        wrappedValue = implicitResolver!.resolve(T.self, argument: argument)!
    }

    public init<A1, A2>(arguments a1: A1, _ a2: A2) {
        wrappedValue = implicitResolver!.resolve(T.self, arguments: a1, a2)!
    }

    // TODO: init overloads
}
