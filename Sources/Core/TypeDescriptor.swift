//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeDescriptor: Hashable {
    let tag: String?
    let type: Any.Type
    private let unwrappedType: Any.Type

    init(tag: String?, type: Any.Type) {
        self.tag = tag
        self.type = type
        unwrappedType = unwrapOptionals(type)
    }

    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(unwrappedType).hash(into: &hasher)
        tag.hash(into: &hasher)
    }

    public static func == (lhs: TypeDescriptor, rhs: TypeDescriptor) -> Bool {
        return lhs.unwrappedType == rhs.unwrappedType && lhs.tag == rhs.tag
    }
}

func tagged<Type>(_: Type.Type, with tag: String?) -> TypeDescriptor {
    return TypeDescriptor(tag: tag, type: Type.self)
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
