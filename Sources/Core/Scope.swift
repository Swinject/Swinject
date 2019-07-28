//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyScope {
    var contextType: Any.Type { get }
    func registry(for context: Any) -> ScopeRegistry
}

public protocol Scope: AnyScope {
    associatedtype Context
    func registry(for context: Context) -> ScopeRegistry
}

public extension Scope {
    var contextType: Any.Type { return Context.self }

    func registry(for context: Any) -> ScopeRegistry {
        return registry(for: context as! Context)
    }
}

public protocol Closable {
    func close()
}

public class UnboundScope: Scope, Closable {
    public typealias Context = Any

    private let _registry: ScopeRegistry

    public init(registry: ScopeRegistry = StandardScopeRegistry()) {
        _registry = registry
    }

    public func registry(for _: Any) -> ScopeRegistry {
        return _registry
    }

    public func close() {
        _registry.clear()
    }
}

extension UnboundScope {
    static let root = UnboundScope()
}
