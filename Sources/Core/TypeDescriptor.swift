//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyTypeDescriptor: Matchable {}

public protocol TypeDescriptor: AnyTypeDescriptor {
    associatedtype BaseType
}

public struct NoTag: Hashable {}

public struct Tagged<BaseType, Tag>: TypeDescriptor where Tag: Hashable {
    let tag: Tag

    public func matches(_ other: Any) -> Bool {
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

    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: hashedType))
        hasher.combine(tag)
    }

    private var hashedType: Any.Type {
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
    Tagged(tag: tag)
}

func plain<Type>(_: Type.Type) -> Tagged<Type, NoTag> {
    Tagged(tag: NoTag())
}

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
    init()
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
    init() { self = .none }
}
