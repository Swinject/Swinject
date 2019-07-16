//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Injector {
    func instance<Descriptor, Argument>(for request: BindingRequest<Descriptor, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

extension Injector {
    // TODO: Get rid of this method
    func provider<Descriptor, Argument>(for request: BindingRequest<Descriptor, Argument>) -> () throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        { try self.instance(for: request) }
    }
}

// TODO: Overloads for multiple arguments
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

    func provider<Type>(of _: Type.Type = Type.self) -> () throws -> Type {
        provider(arg: ())
    }

    func provider<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) -> () throws -> Type {
        provider(tagged: tag, arg: ())
    }

    func provider<Type, Argument>(of _: Type.Type = Type.self, arg: Argument) -> () throws -> Type {
        provider(tagged: NoTag(), arg: arg)
    }

    func provider<Type, Tag: Equatable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag, arg: Argument) -> () throws -> Type {
        provider(for: BindingRequest<Tagged<Type, Tag>, Argument>(
            key: BindingKey(descriptor: tagged(Type.self, with: tag)),
            argument: arg
        ))
    }
}
