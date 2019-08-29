//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol CustomResolvable {
    init(resolver: Resolver, request: AnyInstanceRequest)
    static func requiredRequest(for request: InstanceRequestDescriptor) -> InstanceRequestDescriptor?
    static var delaysResolution: Bool { get }
}

protocol AnyPropertyWrapper: CustomResolvable {
    associatedtype Value
}

protocol PropertyWrapper: AnyPropertyWrapper {
    associatedtype Value
    init(wrappedValue: Value)
}

protocol DelayedPropertyWrapper: AnyPropertyWrapper {
    associatedtype Value
    init(wrappedValue: @autoclosure @escaping () -> Value)
}

extension AnyPropertyWrapper {
    static func requiredRequest(for request: InstanceRequestDescriptor) -> InstanceRequestDescriptor? {
        return request.replacingType(with: Value.self)
    }
}

extension PropertyWrapper {
    init(resolver: Resolver, request: AnyInstanceRequest) {
        // swiftlint:disable:next force_try
        self.init(wrappedValue: try! resolver.resolve(request.replacingType(with: Value.self)))
    }

    static var delaysResolution: Bool { return false }
}

extension DelayedPropertyWrapper {
    init(resolver: Resolver, request: AnyInstanceRequest) {
        // swiftlint:disable:next force_try
        self.init(wrappedValue: try! resolver.resolve(request.replacingType(with: Value.self)))
    }

    static var delaysResolution: Bool { return true }
}

extension AnyInstanceRequest {
    func replacingType<Type>(with _: Type.Type) -> InstanceRequest<Type> {
        return InstanceRequest(
            type: TypeDescriptor(tag: type.tag, type: Type.self),
            arguments: arguments
        )
    }
}

extension InstanceRequestDescriptor {
    func replacingType<Type>(with _: Type.Type) -> InstanceRequestDescriptor {
        return InstanceRequestDescriptor(
            type: TypeDescriptor(tag: type.tag, type: Type.self),
            arguments: arguments
        )
    }
}

extension Optional: CustomResolvable {
    init(resolver: Resolver, request: AnyInstanceRequest) {
        self = try? resolver.resolve(request.replacingType(with: Wrapped.self)) as Wrapped
    }

    static func requiredRequest(for _: InstanceRequestDescriptor) -> InstanceRequestDescriptor? {
        return nil
    }

    static var delaysResolution: Bool { return false }
}
