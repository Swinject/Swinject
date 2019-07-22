//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct InstanceRequest<Descriptor, Argument> where Descriptor: TypeDescriptor {
    let descriptor: Descriptor
    let argument: Argument
}

func request<Type, Tag: Equatable, Argument>(
    type: Type.Type = Type.self,
    tag: Tag,
    arg: Argument
) -> InstanceRequest<Tagged<Type, Tag>, Argument> {
    InstanceRequest(descriptor: tagged(type, with: tag), argument: arg)
}

extension InstanceRequest {
    func key(forContextType contextType: Any.Type) -> BindingKey {
        BindingKey(descriptor: descriptor, contextType: contextType, argumentType: Argument.self)
    }
}
