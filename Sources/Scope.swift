//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Scope {
    associatedtype Context

    static var lock: Lock { get }
    static func registry(for context: Context) -> ScopeRegistry
}

public protocol Lock {}

public protocol ScopeRegistry {
    // FXIME: name `AnyBindingKey` seems out of context here
    func register<Type>(_ instance: Type, for key: AnyBindingKey) where Type: AnyObject
    func instance<Type>(for key: AnyBindingKey) -> Type? where Type: AnyObject
}
