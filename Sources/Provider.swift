//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Provider {
    func instance<Descriptor>(_ type: Descriptor) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

public extension Provider {
    func instance<Type>(of: Type.Type = Type.self) throws -> Type {
        try instance(plain(Type.self))
    }
}
