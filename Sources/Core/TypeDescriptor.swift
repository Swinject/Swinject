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
        return false
    }

    public var hashValue: Int {
        String(describing: hashedType).hashValue ^ tag.hashValue
    }

    private var hashedType: Any.Type {
        if let optional = BaseType.self as? OptionalProtocol.Type {
            return optional.wrappedType
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
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { Wrapped.self }
}
