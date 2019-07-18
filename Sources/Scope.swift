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

public protocol Lock {
    func sync<T>(_ action: () throws -> T) rethrows -> T
}

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
