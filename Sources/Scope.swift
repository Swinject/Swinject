//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyScope {
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

public class ImplicitScope: Scope {
    public typealias Context = Any

    public func registry(for _: Any) -> ScopeRegistry {
        fatalError()
    }
}

extension ImplicitScope {
    static let implicit = ImplicitScope()
}
