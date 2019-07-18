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
        guard let other = other as? Tagged<BaseType, Tag> else { return false }
        return tag == other.tag
    }

    public var hashValue: Int {
        String(describing: BaseType.self).hashValue ^ tag.hashValue
    }
}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> Tagged<Type, Tag> where Tag: Hashable {
    Tagged(tag: tag)
}

func plain<Type>(_: Type.Type) -> Tagged<Type, NoTag> {
    Tagged(tag: NoTag())
}
