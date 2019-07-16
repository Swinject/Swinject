//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingRequest<Descriptor, Argument> where Descriptor: TypeDescriptor {
    let key: BindingKey<Descriptor, Argument>
    let argument: Argument
}

func request<Type, Tag: Equatable, Argument>(type _: Type.Type = Type.self, tag: Tag, arg: Argument) -> BindingRequest<Tagged<Type, Tag>, Argument> {
    BindingRequest(key: BindingKey(descriptor: Tagged<Type, Tag>(tag: tag)), argument: arg)
}
