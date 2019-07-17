//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyScope {
    var lock: Lock { get }
    func registry(for context: Any) -> ScopeRegistry
}

public protocol Scope: AnyScope {
    associatedtype Context
    func registry(for context: Context) -> ScopeRegistry
}

extension Scope {
    func registry(for context: Any) -> ScopeRegistry {
        registry(for: context as! Context)
    }
}

public protocol Lock {}

public protocol ScopeRegistry {
    func register<Type>(_ instance: Type, for key: ScopeRegistryKey)
    func instance<Type>(for key: ScopeRegistryKey) -> Type?
}

public struct ScopeRegistryKey {}

public class ImplicitScope: Scope {
    public typealias Context = Any

    public var lock: Lock { fatalError() }

    public func registry(for _: Any) -> ScopeRegistry {
        fatalError()
    }
}

extension ImplicitScope {
    static let implicit = ImplicitScope()
}
