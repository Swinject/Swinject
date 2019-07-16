//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    func resolve<Descriptor, Context, Argument>(_ request: BindingRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

// TODO: Overloads for multiple arguments & tag / notag combinations
public extension Resolver {
    func instance<Type>(of _: Type.Type = Type.self) throws -> Type {
        try instance(tagged: NoTag())
    }

    func instance<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> Type {
        try resolve(request(tag: tag, arg: ()))
    }

    func provider<Type>(of _: Type.Type = Type.self) -> () throws -> Type {
        provider(tagged: NoTag())
    }

    func provider<Type, Tag: Equatable>(of _: Type.Type = Type.self, tagged tag: Tag) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: ())) }
    }

    func factory<Type, Argument>(of _: Type.Type = Type.self) -> (Argument) throws -> Type {
        factory(tagged: NoTag())
    }

    func factory<Type, Tag: Equatable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Argument) throws -> Type {
        return { try self.resolve(request(tag: tag, arg: $0)) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg: Arg1) -> (Arg2) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg: Arg1) -> (Arg2, Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, args arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg1, arg2, $0))) }
    }
}
