//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct ScopeRegistryKey {
    let descriptor: AnyTypeDescriptor
    let argument: Any
}

extension ScopeRegistryKey: Hashable {
    public static func == (lhs: ScopeRegistryKey, rhs: ScopeRegistryKey) -> Bool {
        lhs.descriptor.matches(rhs.descriptor)
            && rhs.descriptor.matches(lhs.descriptor)
            && (lhs.argument as? Matchable)?.matches(rhs.argument) ?? false
            && (rhs.argument as? Matchable)?.matches(lhs.argument) ?? false
    }

    public func hash(into hasher: inout Hasher) {
        descriptor.hashValue.hash(into: &hasher)
        (argument as? Matchable)?.hashValue.hash(into: &hasher)
    }
}
