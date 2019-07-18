//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol ScopeRegistry {
    func instance(for key: ScopeRegistryKey, builder: () throws -> Any) rethrows -> Any
}

public class StandardScopeRegistry: ScopeRegistry {
    public func instance(for _: ScopeRegistryKey, builder _: () throws -> Any) rethrows -> Any {
        fatalError()
    }
}
