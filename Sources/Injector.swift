//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Injector {
    func instance<Descriptor>(_ descriptor: Descriptor) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

public extension Injector {
    func instance<Type>(of _: Type.Type = Type.self) throws -> Type {
        try instance(plain(Type.self))
    }

    func instance<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> Type {
        try instance(tagged(Type.self, with: tag))
    }
}
