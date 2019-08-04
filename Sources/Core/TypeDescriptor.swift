//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeDescriptor: Hashable {
    let tag: Matchable
    let type: Any.Type

    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(type).hash(into: &hasher)
        tag.hash(into: &hasher)
    }

    public static func == (lhs: TypeDescriptor, rhs: TypeDescriptor) -> Bool {
        return lhs.type == rhs.type && lhs.tag.matches(rhs.tag)
    }
}

struct NoTag: Hashable {}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> TypeDescriptor where Tag: Hashable {
    return TypeDescriptor(tag: box(tag), type: unwrapOptionals(Type.self))
}

func plain<Type>(_: Type.Type) -> TypeDescriptor {
    return tagged(Type.self, with: NoTag())
}

func named<Type>(_: Type.Type, name: String?) -> TypeDescriptor {
    if let name = name {
        return tagged(Type.self, with: name)
    } else {
        return plain(Type.self)
    }
}

func unwrapOptionals(_ type: Any.Type) -> Any.Type {
    guard let optional = type as? OptionalProtocol.Type else { return type }
    return unwrapOptionals(optional.wrappedType)
}

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
}
