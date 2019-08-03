//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyTypeDescriptor {
    var anyTag: Any { get }
    var rootType: Any.Type { get }
    func isEqual(to other: AnyTypeDescriptor) -> Bool
    func hash(into hasher: inout Hasher)
}

struct NoTag: Hashable {}

struct Tagged<Type, Tag>: AnyTypeDescriptor where Tag: Hashable {
    let tag: Tag
    let rootType: Any.Type

    var anyTag: Any { return tag }

    func isEqual(to other: AnyTypeDescriptor) -> Bool {
        if let otherTag = other.anyTag as? Tag {
            return rootType == other.rootType && tag == otherTag
        }
        return false
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(rootType))
        hasher.combine(tag)
    }
}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> Tagged<Type, Tag> where Tag: Hashable {
    return Tagged(tag: tag, rootType: {
        if let optional = Type.self as? OptionalProtocol.Type {
            if let doubleOptional = optional.wrappedType as? OptionalProtocol.Type {
                return doubleOptional.wrappedType
            }
            return optional.wrappedType
        }
        return Type.self
    }())
}

func plain<Type>(_: Type.Type) -> Tagged<Type, NoTag> {
    return tagged(Type.self, with: NoTag())
}

func named<Type>(_: Type.Type, name: String?) -> AnyTypeDescriptor {
    if let name = name {
        return tagged(Type.self, with: name)
    } else {
        return plain(Type.self)
    }
}

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
    init()
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
    init() { self = .none }
}
