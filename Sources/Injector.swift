//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Injector {
    func instance<Descriptor, Argument>(for request: BindingRequest<Descriptor, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor

    // TODO: Move this to extension?
    func provider<Descriptor, Argument>(for request: BindingRequest<Descriptor, Argument>) throws -> () throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

public extension Injector {
    func instance<Type>(of _: Type.Type = Type.self) throws -> Type {
        try instance(arg: ())
    }

    func instance<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> Type {
        try instance(tagged: tag, arg: ())
    }

    func instance<Type, Argument>(of _: Type.Type = Type.self, arg: Argument) throws -> Type {
        try instance(tagged: NoTag(), arg: arg)
    }

    func instance<Type, Tag: Equatable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag, arg: Argument) throws -> Type {
        try instance(for: BindingRequest<Tagged<Type, Tag>, Argument>(
            key: BindingKey(descriptor: tagged(Type.self, with: tag)),
            argument: arg
        ))
    }

    func provider<Type>(of _: Type.Type = Type.self) throws -> () throws -> Type {
        try provider(arg: ())
    }

    func provider<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> () throws -> Type {
        try provider(tagged: tag, arg: ())
    }

    func provider<Type, Argument>(of _: Type.Type = Type.self, arg: Argument) throws -> () throws -> Type {
        try provider(tagged: NoTag(), arg: arg)
    }

    func provider<Type, Tag: Equatable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag, arg: Argument) throws -> () throws -> Type {
        try provider(for: BindingRequest<Tagged<Type, Tag>, Argument>(
            key: BindingKey(descriptor: tagged(Type.self, with: tag)),
            argument: arg
        ))
    }
}
