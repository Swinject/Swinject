//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public extension InstanceRequest {
    func from(_ resolver: Resolver) throws -> Type {
        return try resolver.resolve(self)
    }
}

// swiftlint:disable line_length
// sourcery:inline:InstanceRequestApi
public func instance<Type>(of _: Type.Type = Type.self, tagged tag: String? = nil) -> InstanceRequest<Type> {
    return request(type: Type.self, tag: tag, arg: ())
}

public func instance<Type, Arg1>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1) -> InstanceRequest<Type> {
    return request(type: Type.self, tag: tag, arg: box(arg1))
}

public func instance<Type, Arg1>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1) -> InstanceRequest<Type> where Arg1: Hashable {
    return request(type: Type.self, tag: tag, arg: box(arg1))
}

public func instance<Type, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2) -> InstanceRequest<Type> {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2))
}

public func instance<Type, Arg1, Arg2>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2) -> InstanceRequest<Type> where Arg1: Hashable, Arg2: Hashable {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2))
}

public func instance<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> InstanceRequest<Type> {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2, arg3))
}

public func instance<Type, Arg1, Arg2, Arg3>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> InstanceRequest<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2, arg3))
}

public func instance<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> InstanceRequest<Type> {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2, arg3, arg4))
}

public func instance<Type, Arg1, Arg2, Arg3, Arg4>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> InstanceRequest<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2, arg3, arg4))
}

public func instance<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> InstanceRequest<Type> {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2, arg3, arg4, arg5))
}

public func instance<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(of _: Type.Type = Type.self, tagged tag: String? = nil, arg arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> InstanceRequest<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    return request(type: Type.self, tag: tag, arg: box(arg1, arg2, arg3, arg4, arg5))
}

// sourcery:end
