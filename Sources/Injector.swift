//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Injector {
    func instance<Descriptor, Argument>(for request: BindingRequest<Descriptor, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

extension Injector {}

// TODO: Overloads for multiple arguments & tag / notag combinations
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

    func provider<Type, Argument>(of _: Type.Type = Type.self, arg: Argument) -> () throws -> Type {
        provider(tagged: NoTag(), arg: arg)
    }

    func provider<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) -> () throws -> Type {
        provider(tagged: tag, arg: ())
    }

    func provider<Type, Tag: Equatable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag, arg: Argument) -> () throws -> Type {
        return { try self.instance(tagged: tag, arg: arg) }
    }

    func factory<Type, Argument>(of _: Type.Type = Type.self) -> (Argument) throws -> Type {
        factory(tagged: NoTag())
    }

    func factory<Type, Tag: Equatable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Argument) throws -> Type {
        return { try self.instance(of: Type.self, tagged: tag, arg: $0) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg: Arg1) -> (Arg2) throws -> Type {
        return { try self.instance(of: Type.self, arg: (arg, $0)) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg: Arg1) -> (Arg2, Arg3) throws -> Type {
        return { try self.instance(of: Type.self, arg: (arg, $0, $1)) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, args arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type {
        return { try self.instance(of: Type.self, arg: (arg1, arg2, $0)) }
    }
}
