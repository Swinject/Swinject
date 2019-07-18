//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// TODO: Overloads for multiple arguments & tag / notag combinations

public extension Resolver {
    func instance<Type>(of _: Type.Type = Type.self) throws -> Type {
        try instance(tagged: NoTag(), arg: ())
    }

    func instance<Type, Argument>(of _: Type.Type = Type.self, arg: Argument) throws -> Type {
        try instance(tagged: NoTag(), arg: arg)
    }

    func instance<Type, Tag: Hashable>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> Type {
        try resolve(request(tag: tag, arg: ()))
    }

    func instance<Type, Tag: Hashable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag, arg: Argument) throws -> Type {
        try resolve(request(tag: tag, arg: arg))
    }
}

public extension Resolver {
    func provider<Type>(of _: Type.Type = Type.self) -> () throws -> Type {
        provider(tagged: NoTag(), arg: ())
    }

    func provider<Type, Argument>(of _: Type.Type = Type.self, arg: Argument) -> () throws -> Type {
        provider(tagged: NoTag(), arg: arg)
    }

    func provider<Type, Tag: Hashable>(of _: Type.Type = Type.self, tagged tag: Tag) -> () throws -> Type {
        provider(tagged: tag, arg: ())
    }

    func provider<Type, Tag: Hashable, Argument>(of _: Type.Type = Type.self, tagged tag: Tag, arg: Argument) -> () throws -> Type {
        return { try self.resolve(request(tag: tag, arg: arg)) }
    }
}

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
