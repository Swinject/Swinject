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

    public init<A1, A2>(arguments arg1: A1, _ arg2: A2) {
        wrappedValue = implicitResolver!.resolve(T.self, arguments: arg1, arg2)!
    }

    // TODO: init overloads
}

@propertyWrapper
public struct LazyInjected<T> {
    @Injected private var lazy: Lazy<T>

    public var wrappedValue: T { return lazy.instance }

    public init() {}
}

@propertyWrapper
public struct ProviderInjected<T> {
    @Injected private var lazy: Provider<T>

    public var wrappedValue: T { return lazy.instance }

    public init() {}
}

