//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyScope {
    var contextType: Any.Type { get }
    func registry(for context: Any) -> ScopeRegistry
}

public protocol Scope: AnyScope {
    associatedtype Context
    func registry(for context: Context) -> ScopeRegistry
}

extension Scope {
    public var contextType: Any.Type { return Context.self }
    
    func registry(for context: Any) -> ScopeRegistry {
        registry(for: context as! Context)
    }
}

public class UnboundScope: Scope, Closable {
    public typealias Context = Any

    private let _registry: ScopeRegistry

    public init(registry: ScopeRegistry = StandardScopeRegistry()) {
        _registry = registry
    }

    public func registry(for _: Any) -> ScopeRegistry {
        _registry
    }

    public func close() {
        _registry.clear()
    }
}

extension UnboundScope {
    static let root = UnboundScope()
}
