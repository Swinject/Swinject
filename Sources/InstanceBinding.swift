//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// TODO: Make internal
public struct InstanceBinding<Type>: Binding {
    public typealias BoundType = Type

    private let _instance: Type

    init(_ instance: Type) {
        _instance = instance
    }

    public func instance(using _: Injector) throws -> Type {
        _instance
    }
}

public func instance<Type>(_ instance: Type) -> InstanceBinding<Type> {
    InstanceBinding(instance)
}
