//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyTypeDescriptor: Matchable {}

public protocol TypeDescriptor: AnyTypeDescriptor {
    associatedtype BaseType
}

public struct SomeTypeDescriptor<BaseType>: TypeDescriptor, Opaque {
    let actual: AnyTypeDescriptor

    public func matches(_ other: Any) -> Bool {
        if let other = other as? AnyOpaque {
            return actual.matches(other.anyActual)
        } else {
            return actual.matches(other)
        }
    }

    public func hash(into hasher: inout Hasher) {
        actual.hash(into: &hasher)
    }
}

public extension TypeDescriptor {
    var opaque: SomeTypeDescriptor<BaseType> { return SomeTypeDescriptor(actual: self) }
}

struct NoTag: Hashable {}

struct Tagged<BaseType, Tag>: TypeDescriptor where Tag: Hashable {
    let tag: Tag

    func matches(_ other: Any) -> Bool {
        if let other = other as? Tagged<BaseType, Tag> {
            return tag == other.tag
        }
        if let other = other as? Tagged<BaseType?, Tag> {
            return tag == other.tag
        }
        if let other = other as? Tagged<BaseType??, Tag> {
            return tag == other.tag
        }
        return false
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(hashedType))
        hasher.combine(tag)
    }

    var hashedType: Any.Type {
        if let optional = BaseType.self as? OptionalProtocol.Type {
            if let doubleOptional = optional.wrappedType as? OptionalProtocol.Type {
                return doubleOptional.wrappedType
            } else {
                return optional.wrappedType
            }
        } else {
            return BaseType.self
        }
    }
}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> Tagged<Type, Tag> where Tag: Hashable {
    return Tagged(tag: tag)
}

func plain<Type>(_: Type.Type) -> Tagged<Type, NoTag> {
    return Tagged(tag: NoTag())
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
