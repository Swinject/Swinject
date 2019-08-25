//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol AnyInstanceRequest: Matchable {
    var type: TypeDescriptor { get }
    var arguments: Arguments { get }
}

public struct InstanceRequest<Type>: AnyInstanceRequest, Hashable {
    let type: TypeDescriptor
    let arguments: Arguments
}

func request<Type>(
    type: Type.Type = Type.self,
    tag: String?,
    arg: Arguments
) -> InstanceRequest<Type> {
    return InstanceRequest(type: tagged(type, with: tag), arguments: arg)
}

extension AnyInstanceRequest {
    func key(forContextType contextType: Any.Type) -> BindingKey {
        return BindingKey(type: type, contextType: contextType, arguments: arguments.descriptor)
    }
}
