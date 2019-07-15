//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyTypeDescriptor {
    func matches(_ other: AnyTypeDescriptor) -> Bool
}

public protocol TypeDescriptor: AnyTypeDescriptor {
    associatedtype BaseType
}

public struct NoTag: Equatable {}

public struct Tagged<BaseType, Tag>: TypeDescriptor where Tag: Equatable {
    let tag: Tag

    public func matches(_ other: AnyTypeDescriptor) -> Bool {
        guard let other = other as? Tagged<BaseType, Tag> else { return false }
        return tag == other.tag
    }
}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> Tagged<Type, Tag> where Tag: Equatable {
    Tagged(tag: tag)
}

func plain<Type>(_: Type.Type) -> Tagged<Type, NoTag> {
    Tagged(tag: NoTag())
}
