//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyPartialRequest {
    var asDependency: BindingDependency { get }
}

extension AnyPartialRequest {
    var asArgumentDependency: Any.Type? {
        if case let .argument(type) = asDependency { return type } else { return nil }
    }
}

public protocol PartialRequest: AnyPartialRequest {
    associatedtype Result
    func fulfill(with resolver: Resolver, and arguments: Arguments) throws -> Result
}

public struct ContextRequest<Type> {}

public struct ArgumentRequest<Type> {
    let index: Int
}

public func context<Type>(as _: Type.Type = Type.self) -> ContextRequest<Type> {
    return ContextRequest()
}

public func argument<Type>(_ index: Int, as _: Type.Type = Type.self) -> ArgumentRequest<Type> {
    return ArgumentRequest(index: index)
}

extension InstanceRequest: PartialRequest {
    public var asDependency: BindingDependency { return .instance(type, arguments.descriptor) }

    public func fulfill(with resolver: Resolver, and _: Arguments) throws -> Type {
        return try resolver.resolve(self)
    }
}

extension ArgumentRequest: PartialRequest {
    public var asDependency: BindingDependency { return .argument(Type.self) }

    public func fulfill(with _: Resolver, and arguments: Arguments) throws -> Type {
        return try arguments.arg(index)
    }
}

extension ContextRequest: PartialRequest {
    public var asDependency: BindingDependency { return .context(Type.self) }

    public func fulfill(with resolver: Resolver, and _: Arguments) throws -> Type {
        return try resolver.contexted().context()
    }
}
