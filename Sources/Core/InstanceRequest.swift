//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol AnyInstanceRequest {
    var descriptor: AnyTypeDescriptor { get }
    var argument: Any { get }
    var argumentType: Any.Type { get }
}

public struct InstanceRequest<Type, Tag, Argument>: AnyInstanceRequest where Tag: Hashable {
    let argumentType: Any.Type = Argument.self
    let descriptor: AnyTypeDescriptor
    let argument: Any
}

func request<Type, Tag: Hashable, Argument>(
    type: Type.Type = Type.self,
    tag: Tag,
    arg: Argument
) -> InstanceRequest<Type, Tag, Argument> {
    return InstanceRequest(descriptor: tagged(type, with: tag), argument: arg)
}

extension AnyInstanceRequest {
    func key(forContextType contextType: Any.Type) -> BindingKey {
        return BindingKey(descriptor: descriptor, contextType: contextType, argumentType: argumentType)
    }
}
