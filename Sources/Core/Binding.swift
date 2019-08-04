//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingKey: Hashable {
    let descriptor: TypeDescriptor
    let contextType: Any.Type
    let argumentType: Any.Type

    init(descriptor: TypeDescriptor, contextType: Any.Type, argumentType: Any.Type) {
        self.descriptor = descriptor
        self.contextType = unwrapOptionals(contextType)
        self.argumentType = argumentType
    }

    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        ObjectIdentifier(contextType).hash(into: &hasher)
        ObjectIdentifier(argumentType).hash(into: &hasher)
    }

    public static func == (lhs: BindingKey, rhs: BindingKey) -> Bool {
        return lhs.descriptor == rhs.descriptor
            && lhs.contextType == rhs.contextType
            && lhs.argumentType == rhs.argumentType
    }
}

extension BindingKey {
    func matches(contextType: Any.Type) -> Bool {
        return self.contextType == Any.self || self.contextType == unwrapOptionals(contextType)
    }
}

public protocol Binding: SwinjectEntry {
    var key: BindingKey { get }
    var properties: BindingProperties { get }
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}
