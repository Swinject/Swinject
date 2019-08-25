//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol CustomResolvable {
    init(resolver: Resolver, request: AnyInstanceRequest)
    static func requiredRequest(for request: AnyInstanceRequest) -> AnyInstanceRequest?
}

protocol PropertyWrapper: CustomResolvable {
    associatedtype Value
    init(wrappedValue: @autoclosure @escaping () -> Value)
}

extension PropertyWrapper {
    init(resolver: Resolver, request: AnyInstanceRequest) {
        // swiftlint:disable:next force_try
        self.init(wrappedValue: try! resolver.resolve(request.replacingType(with: Value.self)))
    }

    static func requiredRequest(for request: AnyInstanceRequest) -> AnyInstanceRequest? {
        if let wrapper = Value.self as? CustomResolvable.Type {
            return wrapper.requiredRequest(for: request)
        } else {
            return request.replacingType(with: Value.self)
        }
    }
}

extension AnyInstanceRequest {
    func replacingType<Type>(with _: Type.Type) -> InstanceRequest<Type> {
        return InstanceRequest(
            type: TypeDescriptor(
                tag: type.tag,
                type: Type.self
            ),
            arguments: arguments
        )
    }
}

extension Optional: CustomResolvable {
    init(resolver: Resolver, request: AnyInstanceRequest) {
        self = try? resolver.resolve(request.replacingType(with: Wrapped.self)) as Wrapped
    }

    static func requiredRequest(for _: AnyInstanceRequest) -> AnyInstanceRequest? {
        return nil
    }
}
