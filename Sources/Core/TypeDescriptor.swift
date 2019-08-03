//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeDescriptor {
    let tag: Matchable
    let rootType: Any.Type

    func isEqual(to other: TypeDescriptor) -> Bool {
        return rootType == other.rootType && tag.matches(other.tag)
    }

    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(rootType).hash(into: &hasher)
        tag.hash(into: &hasher)
    }
}

struct NoTag: Hashable {}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> TypeDescriptor where Tag: Hashable {
    return TypeDescriptor(tag: box(tag), rootType: {
        if let optional = Type.self as? OptionalProtocol.Type {
            if let doubleOptional = optional.wrappedType as? OptionalProtocol.Type {
                return doubleOptional.wrappedType
            }
            return optional.wrappedType
        }
        return Type.self
    }())
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

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
}
