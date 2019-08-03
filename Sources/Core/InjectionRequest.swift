//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct InjectionRequest {
    let descriptor: TypeDescriptor
    let argument: Any
    let argumentType: Any.Type
}

func request<Type, Tag: Hashable, Argument>(
    type: Type.Type = Type.self,
    tag: Tag,
    arg: Argument
) -> InjectionRequest {
    return InjectionRequest(descriptor: tagged(type, with: tag), argument: arg, argumentType: Argument.self)
}

extension InjectionRequest {
    func key(forContextType contextType: Any.Type) -> BindingKey {
        return BindingKey(descriptor: descriptor, contextType: contextType, argumentType: argumentType)
    }
}
