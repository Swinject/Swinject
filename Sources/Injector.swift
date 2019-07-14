//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Injector {
    func instance<Descriptor, Dependency>(_ descriptor: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

public extension Injector {
    func instance<Type>(of: Type.Type = Type.self) throws -> Type {
        try instance(plain(Type.self), with: ())
    }

    func instance<Type, Tag: Equatable>(of: Type.Type = Type.self, tagged tag: Tag) throws -> Type {
        try instance(tagged(Type.self, with: tag), with: ())
    }

    func instance<Type, Dependency>(of: Type.Type = Type.self, with dependency: Dependency) throws -> Type {
        try instance(plain(Type.self), with: dependency)
    }
}
