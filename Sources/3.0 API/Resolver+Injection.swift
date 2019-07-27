//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable function_parameter_count
// swiftlint:disable file_length
// sourcery:inline:ResolverInjectionApi
public extension Resolver {
    func instance<Type>(of _: Type.Type = Type.self) throws -> Type {
        try resolve(request(tag: NoTag(), arg: ()))
    }

    func instance<Type, Tag>(of _: Type.Type = Type.self, tagged tag: Tag) throws -> Type where Tag: Hashable {
        try resolve(request(tag: tag, arg: ()))
    }

    func instance<Type, Arg1>(of _: Type.Type = Type.self, arg arg1: Arg1) throws -> Type {
        try resolve(request(tag: NoTag(), arg: box(arg1)))
    }

    func instance<Type, Arg1>(of _: Type.Type = Type.self, arg arg1: Arg1) throws -> Type where Arg1: Hashable {
        try resolve(request(tag: NoTag(), arg: box(arg1)))
    }

    func instance<Type, Tag, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) throws -> Type where Tag: Hashable {
        try resolve(request(tag: tag, arg: box(arg1)))
    }

    func instance<Type, Tag, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) throws -> Type where Tag: Hashable, Arg1: Hashable {
        try resolve(request(tag: tag, arg: box(arg1)))
    }

    func instance<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) throws -> Type {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2)))
    }

    func instance<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) throws -> Type where Arg1: Hashable, Arg2: Hashable {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2)))
    }

    func instance<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) throws -> Type where Tag: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2)))
    }

    func instance<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2)))
    }

    func instance<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> Type {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3)))
    }

    func instance<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3)))
    }

    func instance<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> Type where Tag: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2, arg3)))
    }

    func instance<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2, arg3)))
    }

    func instance<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) throws -> Type {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4)))
    }

    func instance<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4)))
    }

    func instance<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) throws -> Type where Tag: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4)))
    }

    func instance<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4)))
    }

    func instance<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) throws -> Type {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4, arg5)))
    }

    func instance<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        try resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4, arg5)))
    }

    func instance<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) throws -> Type where Tag: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4, arg5)))
    }

    func instance<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        try resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4, arg5)))
    }
}

public extension Resolver {
    func provider<Type>(of _: Type.Type = Type.self) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: ())) }
    }

    func provider<Type, Tag>(of _: Type.Type = Type.self, tagged tag: Tag) -> () throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: ())) }
    }

    func provider<Type, Arg1>(of _: Type.Type = Type.self, arg arg1: Arg1) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1))) }
    }

    func provider<Type, Arg1>(of _: Type.Type = Type.self, arg arg1: Arg1) -> () throws -> Type where Arg1: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1))) }
    }

    func provider<Type, Tag, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> () throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1))) }
    }

    func provider<Type, Tag, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> () throws -> Type where Tag: Hashable, Arg1: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1))) }
    }

    func provider<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2))) }
    }

    func provider<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> () throws -> Type where Arg1: Hashable, Arg2: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2))) }
    }

    func provider<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> () throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2))) }
    }

    func provider<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> () throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2))) }
    }

    func provider<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3))) }
    }

    func provider<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> () throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3))) }
    }

    func provider<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> () throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3))) }
    }

    func provider<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> () throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3))) }
    }

    func provider<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4))) }
    }

    func provider<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> () throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4))) }
    }

    func provider<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> () throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4))) }
    }

    func provider<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> () throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4))) }
    }

    func provider<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> () throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4, arg5))) }
    }

    func provider<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> () throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4, arg5))) }
    }

    func provider<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> () throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4, arg5))) }
    }

    func provider<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> () throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4, arg5))) }
    }
}

public extension Resolver {
    func factory<Type, Arg1>(of _: Type.Type = Type.self) -> (Arg1) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box($0))) }
    }

    func factory<Type, Arg1>(of _: Type.Type = Type.self) -> (Arg1) throws -> Type where Arg1: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box($0))) }
    }

    func factory<Type, Tag, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0))) }
    }

    func factory<Type, Tag, Arg1>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1) throws -> Type where Tag: Hashable, Arg1: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0))) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self) -> (Arg1, Arg2) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1))) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0))) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self) -> (Arg1, Arg2) throws -> Type where Arg1: Hashable, Arg2: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1))) }
    }

    func factory<Type, Arg1, Arg2>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2) throws -> Type where Arg1: Hashable, Arg2: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2, Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2, Arg3) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2, Arg3) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1, $2))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2, Arg3) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2, Arg3) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1, $2))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2, Arg3) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3, Arg4) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1, $2, $3))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2, Arg3, Arg4) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3, Arg4) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1, $2, $3))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2, Arg3, Arg4) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2, Arg3, Arg4) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1, $2, $3))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2, Arg3, Arg4) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0, $1, $2))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, $0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2, Arg3, Arg4) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1, $2, $3))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2, Arg3, Arg4) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0, $1, $2))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, $0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1, $2, $3, $4))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2, Arg3, Arg4, Arg5) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0, $1, $2, $3))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4, Arg5) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, $0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4, Arg5) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> (Arg5) throws -> Type {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4, $0))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self) -> (Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box($0, $1, $2, $3, $4))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1) -> (Arg2, Arg3, Arg4, Arg5) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, $0, $1, $2, $3))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4, Arg5) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, $0, $1, $2))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4, Arg5) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, $0, $1))) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> (Arg5) throws -> Type where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: NoTag(), arg: box(arg1, arg2, arg3, arg4, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1, $2, $3, $4))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2, Arg3, Arg4, Arg5) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0, $1, $2, $3))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4, Arg5) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, $0, $1, $2))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4, Arg5) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, $0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> (Arg5) throws -> Type where Tag: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4, $0))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag) -> (Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: tag, arg: box($0, $1, $2, $3, $4))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1) -> (Arg2, Arg3, Arg4, Arg5) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, $0, $1, $2, $3))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2) -> (Arg3, Arg4, Arg5) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, $0, $1, $2))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg4, Arg5) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, $0, $1))) }
    }

    func factory<Type, Tag, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: Tag, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> (Arg5) throws -> Type where Tag: Hashable, Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return { try self.resolve(request(tag: tag, arg: box(arg1, arg2, arg3, arg4, $0))) }
    }
}

// sourcery:end
