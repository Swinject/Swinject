//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol ScopeRegistry {
    func register(_ instance: Any, for key: ScopeRegistryKey)
    func instance(for key: ScopeRegistryKey) -> Any?
}

public class StandardScopeRegistry: ScopeRegistry {
    public func register(_: Any, for _: ScopeRegistryKey) {
        fatalError()
    }

    public func instance(for _: ScopeRegistryKey) -> Any? {
        nil
    }
}
