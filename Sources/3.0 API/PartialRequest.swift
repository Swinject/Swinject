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
    func fulfill(with resolver: Resolver, and arguments: Arguments) throws -> Any
}

protocol PartialRequest: AnyPartialRequest {
    associatedtype Result
    func fulfill(with resolver: Resolver, and arguments: Arguments) throws -> Result
}

extension PartialRequest {
    public func fulfill(with resolver: Resolver, and arguments: Arguments) throws -> Any {
        return try fulfill(with: resolver, and: arguments) as Result
    }
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

    func fulfill(with resolver: Resolver, and _: Arguments) throws -> Type {
        return try resolver.resolve(self)
    }
}

extension ArgumentRequest: PartialRequest {
    public var asDependency: PartialDependency { return .argument(Type.self) }

    func fulfill(with _: Resolver, and arguments: Arguments) throws -> Type {
        return try arguments.arg(index)
    }
}

extension ContextRequest: PartialRequest {
    public var asDependency: PartialDependency { return .context(Type.self) }

    func fulfill(with resolver: Resolver, and _: Arguments) throws -> Type {
        return try resolver.contexted().context()
    }
}
