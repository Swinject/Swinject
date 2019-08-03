//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol InstanceProvider {
    init<Type, Tag, Argument>(resolver: Resolver, request: InstanceRequest<Type, Tag, Argument>)
    static func transform<Type, Tag, Argument>(_ request: InstanceRequest<Type, Tag, Argument>) -> AnyInstanceRequest
}

@propertyWrapper public enum Lazy<Value> {
    case uninitialized(() -> Value)
    case initialized(Value)

    public init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }

    public var wrappedValue: Value {
        mutating get {
            switch self {
            case let .uninitialized(initializer):
                let value = initializer()
                self = .initialized(value)
                return value
            case let .initialized(value):
                return value
            }
        }
        set {
            self = .initialized(newValue)
        }
    }
}

extension Lazy: InstanceProvider {
    init<Type, Tag, Argument>(resolver: Resolver, request: InstanceRequest<Type, Tag, Argument>) {
        self.init(wrappedValue: try! resolver.instance( // swiftlint:disable:this force_try
            tagged: request.descriptor.anyTag as! Tag,
            arg: request.argument as! Argument
        ))
    }

    static func transform<Type, Tag, Argument>(_ aRequest: InstanceRequest<Type, Tag, Argument>) -> AnyInstanceRequest {
        return request(type: Value.self, tag: aRequest.descriptor.anyTag as! Tag, arg: aRequest.argument as! Argument)
    }
}
