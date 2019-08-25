//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public enum PartialDependency {
    case instance(TypeDescriptor, Arguments.Descriptor)
    case argument(Any.Type)
    case context(Any.Type)
}

public protocol AnyPartialRequest {
    var asDependency: PartialDependency { get }
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
    public var asDependency: PartialDependency { return .instance(type, arguments.descriptor) }

    public func fulfill(with resolver: Resolver, and _: Arguments) throws -> Type {
        return try resolver.resolve(self)
    }
}

extension ArgumentRequest: PartialRequest {
    public var asDependency: PartialDependency { return .argument(Type.self) }

    public func fulfill(with _: Resolver, and arguments: Arguments) throws -> Type {
        return try arguments.arg(index)
    }
}

extension ContextRequest: PartialRequest {
    public var asDependency: PartialDependency { return .context(Type.self) }

    public func fulfill(with resolver: Resolver, and _: Arguments) throws -> Type {
        return try resolver.contexted().context()
    }
}
