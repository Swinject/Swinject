//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyTypeDescriptor {
    func matches<Descriptor>(_ other: Descriptor) -> Bool where Descriptor: TypeDescriptor
}

public protocol TypeDescriptor: AnyTypeDescriptor {
    associatedtype BaseType
}

struct NoTag: Equatable {}

struct Tagged<BaseType, Tag>: TypeDescriptor where Tag: Equatable{
    let tag: Tag

    func matches<Descriptor>(_ other: Descriptor) -> Bool where Descriptor : TypeDescriptor {
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
