//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

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
