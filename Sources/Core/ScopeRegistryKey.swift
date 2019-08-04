//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct ScopeRegistryKey {
    let descriptor: TypeDescriptor
    let argument: Any
}

extension ScopeRegistryKey: Hashable {
    public static func == (lhs: ScopeRegistryKey, rhs: ScopeRegistryKey) -> Bool {
        return lhs.descriptor == rhs.descriptor && areArgumentsEqual(lhs.argument, rhs.argument)
    }

    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        (argument as? Matchable)?.hash(into: &hasher)
    }
}

func areArgumentsEqual(_ lhs: Any, _ rhs: Any) -> Bool {
    switch (lhs, rhs) {
    case let (lhs as Matchable, _): return lhs.matches(rhs)
    case let (_, rhs as Matchable): return rhs.matches(lhs)
    default: return true
    }
}
