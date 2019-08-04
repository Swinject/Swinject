//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct InjectionRequest: Hashable {
    let descriptor: TypeDescriptor
    let argument: Any
    let argumentType: Any.Type

    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        ObjectIdentifier(argumentType).hash(into: &hasher)
        (argument as? Matchable)?.hash(into: &hasher)
    }

    public static func == (lhs: InjectionRequest, rhs: InjectionRequest) -> Bool {
        return lhs.descriptor == rhs.descriptor
            && lhs.argumentType == rhs.argumentType
            && areArgumentsEqual(lhs.argument, rhs.argument)
    }
}

func request<Type, Argument>(
    type: Type.Type = Type.self,
    tag: String?,
    arg: Argument
) -> InjectionRequest {
    return InjectionRequest(descriptor: tagged(type, with: tag), argument: arg, argumentType: Argument.self)
}

extension InjectionRequest {
    func key(forContextType contextType: Any.Type) -> BindingKey {
        return BindingKey(descriptor: descriptor, contextType: contextType, argumentType: argumentType)
    }
}
