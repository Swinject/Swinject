//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct InstanceRequest<Descriptor, Context, Argument> where Descriptor: TypeDescriptor {
    let key: BindingKey<Descriptor, Context, Argument>
    let context: Context
    let argument: Argument
}

func request<Type, Tag: Equatable, Argument>(type _: Type.Type = Type.self, tag: Tag, arg: Argument) -> InstanceRequest<Tagged<Type, Tag>, Void, Argument> {
    InstanceRequest(key: BindingKey(descriptor: Tagged<Type, Tag>(tag: tag)), context: (), argument: arg)
}
