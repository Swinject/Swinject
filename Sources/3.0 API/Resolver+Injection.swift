//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable function_parameter_count
// sourcery:inline:ResolverInjectionApi
public extension Resolver {
    func instance<Type>(of _: Type.Type = Type.self) throws -> Type {
        try resolve(request(tag: NoTag(), arg: ()))
    }

    func instance<Type, Tag: Hashable>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> Type {
        try resolve(request(tag: tag, arg: ()))
    }

    func instance<Type, Arg1>(of _: Type.Type = Type.self, arg arg1: Arg1) throws -> Type {
        try resolve(request(tag: NoTag(), arg: arg1))
    }

    func instance<Type, Tag: Hashable, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) throws -> Type {
        try resolve(request(tag: tag, arg: arg1))
    }

    func instance<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) throws -> Type {
        try resolve(request(tag: NoTag(), arg: (arg1, arg2)))
    }

    func instance<Type, Tag: Hashable, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) throws -> Type {
        try resolve(request(tag: tag, arg: (arg1, arg2)))
    }

    func instance<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> Type {
        try resolve(request(tag: NoTag(), arg: (arg1, arg2, arg3)))
    }

    func instance<Type, Tag: Hashable, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> Type {
        try resolve(request(tag: tag, arg: (arg1, arg2, arg3)))
    }

    func instance<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) throws -> Type {
        try resolve(request(tag: NoTag(), arg: (arg1, arg2, arg3, arg4)))
    }

    func instance<Type, Tag: Hashable, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) throws -> Type {
        try resolve(request(tag: tag, arg: (arg1, arg2, arg3, arg4)))
    }

    func instance<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) throws -> Type {
        try resolve(request(tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5)))
    }

    func instance<Type, Tag: Hashable, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) throws -> Type {
        try resolve(request(tag: tag, arg: (arg1, arg2, arg3, arg4, arg5)))
    }
}

public extension Resolver {
    func provider<Type>(of _: Type.Type = Type.self) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: ())) }
    }

    func provider<Type, Tag: Hashable>(of _: Type.Type = Type.self, tagged tag: Tag) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: ())) }
    }

    func provider<Type, Arg1>(of _: Type.Type = Type.self, arg arg1: Arg1) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: arg1)) }
    }

    func provider<Type, Tag: Hashable, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: arg1)) }
    }

    func provider<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg1, arg2))) }
    }

    func provider<Type, Tag: Hashable, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: (arg1, arg2))) }
    }

    func provider<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg1, arg2, arg3))) }
    }

    func provider<Type, Tag: Hashable, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: (arg1, arg2, arg3))) }
    }

    func provider<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg1, arg2, arg3, arg4))) }
    }

    func provider<Type, Tag: Hashable, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: (arg1, arg2, arg3, arg4))) }
    }

    func provider<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5))) }
    }

    func provider<Type, Tag: Hashable, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: (arg1, arg2, arg3, arg4, arg5))) }
    }
}

// sourcery:end


// TODO: Generate
public extension Resolver {
    func factory<Type, Argument>(of _: Type.Type = Type.self) -> (Argument) throws -> Type {
        factory(tagged: NoTag())
    }

    func factory<Type, Tag: Hashable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Argument) throws -> Type {
        return { try self.resolve(request(tag: tag, arg: $0)) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self) -> (Arg1, Arg2) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: ($0, $1))) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg: Arg1) -> (Arg2) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: ($0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg: Arg1) -> (Arg2, Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, args arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: (arg1, arg2, $0))) }
    }
}
