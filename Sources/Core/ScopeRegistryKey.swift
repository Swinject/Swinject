//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct ScopeRegistryKey {
    let descriptor: AnyTypeDescriptor
    let argument: Any
}

extension ScopeRegistryKey: Hashable {
    public static func == (lhs: ScopeRegistryKey, rhs: ScopeRegistryKey) -> Bool {
        areDescriptorsEqual(lhs.descriptor, rhs.descriptor) && areArgumentsEqual(lhs.argument, rhs.argument)
    }

    private static func areDescriptorsEqual(_ lhs: AnyTypeDescriptor, _ rhs: AnyTypeDescriptor) -> Bool {
        lhs.matches(rhs) && rhs.matches(lhs)
    }

    private static func areArgumentsEqual(_ lhs: Any, _ rhs: Any) -> Bool {
        switch (lhs, rhs) {
        case is (Void, Void):
            return true
        case let (lhs as Matchable, rhs as Matchable):
            return lhs.matches(rhs) && rhs.matches(lhs)
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        (argument as? Matchable)?.hash(into: &hasher)
    }
}
