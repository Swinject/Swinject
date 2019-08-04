//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol CustomResolvable {
    init(resolver: Resolver, request: InjectionRequest)
    static func requiredRequest(for request: InjectionRequest) -> InjectionRequest?
}

protocol PropertyWrapper: CustomResolvable {
    associatedtype Value
    init(wrappedValue: @autoclosure @escaping () -> Value)
}

extension PropertyWrapper {
    init(resolver: Resolver, request: InjectionRequest) {
        // swiftlint:disable:next force_try
        self.init(wrappedValue: try! resolver.resolve(request.replacingType(with: Value.self)))
    }

    static func requiredRequest(for request: InjectionRequest) -> InjectionRequest? {
        if let wrapper = Value.self as? CustomResolvable.Type {
            return wrapper.requiredRequest(for: request)
        } else {
            return request.replacingType(with: Value.self)
        }
    }
}

extension InjectionRequest {
    func replacingType<Type>(with _: Type.Type) -> InjectionRequest {
        return InjectionRequest(
            descriptor: TypeDescriptor(
                tag: descriptor.tag,
                rootType: Type.self
            ),
            argument: argument,
            argumentType: argumentType
        )
    }
}

extension Optional: CustomResolvable {
    init(resolver _: Resolver, request _: InjectionRequest) {
        self = nil
    }

    static func requiredRequest(for _: InjectionRequest) -> InjectionRequest? {
        return nil
    }
}
