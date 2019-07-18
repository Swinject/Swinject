//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol ScopeRegistry {
    func register(_ instance: Any, for key: ScopeRegistryKey)
    func instance(for key: ScopeRegistryKey) -> Any?
}

public class StandardScopeRegistry: ScopeRegistry {
    private var entries = [ScopeRegistryKey: [Any]]()

    public func register(_ instance: Any, for key: ScopeRegistryKey) {
        entries[key, default: []].append(instance)
    }

    public func instance(for key: ScopeRegistryKey) -> Any? {
        entries[key]?.last
    }
}
