//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol AnyPropertyWrapper {
    init<Type, Tag, Argument>(resolver: Resolver, request: InstanceRequest<Type, Tag, Argument>)
    static func transform<Type, Tag, Argument>(_ request: InstanceRequest<Type, Tag, Argument>) -> AnyInstanceRequest
}

protocol PropertyWrapper: AnyPropertyWrapper {
    associatedtype Value
    init(wrappedValue: @autoclosure @escaping () -> Value)
}

extension PropertyWrapper {
    init<Type, Tag, Argument>(resolver: Resolver, request: InstanceRequest<Type, Tag, Argument>) {
        self.init(wrappedValue: try! resolver.instance( // swiftlint:disable:this force_try
            tagged: request.descriptor.anyTag as! Tag,
            arg: request.argument as! Argument
        ))
    }

    static func transform<Type, Tag, Argument>(_ aRequest: InstanceRequest<Type, Tag, Argument>) -> AnyInstanceRequest {
        if let wrapper = Value.self as? AnyPropertyWrapper.Type {
            return wrapper.transform(aRequest)
        } else {
            return request(
                type: Value.self,
                tag: aRequest.descriptor.anyTag as! Tag,
                arg: aRequest.argument as! Argument
            )
        }
    }
}
