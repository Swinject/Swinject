//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeDescriptor: Hashable {
    let tag: String?
    let type: Any.Type

    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(type).hash(into: &hasher)
        tag.hash(into: &hasher)
    }

    public static func == (lhs: TypeDescriptor, rhs: TypeDescriptor) -> Bool {
        return lhs.type == rhs.type && lhs.tag == rhs.tag
    }
}

func tagged<Type>(_: Type.Type, with tag: String?) -> TypeDescriptor {
    return TypeDescriptor(tag: tag, type: unwrapOptionals(Type.self))
}

func unwrapOptionals(_ type: Any.Type) -> Any.Type {
    guard let optional = type as? OptionalProtocol.Type else { return type }
    return unwrapOptionals(optional.wrappedType)
}

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
}
