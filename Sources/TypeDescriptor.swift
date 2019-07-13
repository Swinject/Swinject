//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyTypeDescriptor {}

public protocol TypeDescriptor: AnyTypeDescriptor {
    associatedtype BaseType
}

struct NoTag: Equatable {}

struct Tagged<BaseType, Tag>: TypeDescriptor where Tag: Equatable{
    let tag: Tag
}

func tagged<Type, Tag>(_: Type.Type, with tag: Tag) -> Tagged<Type, Tag> where Tag: Equatable {
    Tagged(tag: tag)
}

func plain<Type>(_: Type.Type) -> Tagged<Type, NoTag> {
    Tagged(tag: NoTag())
}
