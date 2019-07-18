//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable variable_name

@testable import Swinject

class AnyBindingKeyMock: AnyBindingKey {
    var contextType: Any.Type {
        get { return underlyingContextType }
        set(value) { underlyingContextType = value }
    }

    var underlyingContextType: Any.Type!
    var argumentType: Any.Type {
        get { return underlyingArgumentType }
        set(value) { underlyingArgumentType = value }
    }

    var underlyingArgumentType: Any.Type!
    var descriptor: AnyTypeDescriptor {
        get { return underlyingDescriptor }
        set(value) { underlyingDescriptor = value }
    }

    var underlyingDescriptor: AnyTypeDescriptor!

    // MARK: - matches

    var matchesCallsCount = 0
    var matchesCalled: Bool {
        return matchesCallsCount > 0
    }

    var matchesReceivedOther: AnyBindingKey?
    var matchesReceivedInvocations: [AnyBindingKey] = []
    var matchesReturnValue: Bool!
    var matchesClosure: ((AnyBindingKey) -> Bool)?

    func matches(_ other: AnyBindingKey) -> Bool {
        matchesCallsCount += 1
        matchesReceivedOther = other
        matchesReceivedInvocations.append(other)
        return matchesClosure.map { $0(other) } ?? matchesReturnValue
    }
}

class AnyBindningMakerMock: AnyBindningMaker {
    // MARK: - makeBinding

    var makeBindingForCallsCount = 0
    var makeBindingForCalled: Bool {
        return makeBindingForCallsCount > 0
    }

    var makeBindingForReceivedDescriptor: AnyTypeDescriptor?
    var makeBindingForReceivedInvocations: [AnyTypeDescriptor] = []
    var makeBindingForReturnValue: Binding!
    var makeBindingForClosure: ((AnyTypeDescriptor) -> Binding)?

    func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding {
        makeBindingForCallsCount += 1
        makeBindingForReceivedDescriptor = descriptor
        makeBindingForReceivedInvocations.append(descriptor)
        return makeBindingForClosure.map { $0(descriptor) } ?? makeBindingForReturnValue
    }
}

class AnyInstanceMakerMock: AnyInstanceMaker {
    // MARK: - makeInstance

    var makeInstanceArgContextResolverThrowableError: Error?
    var makeInstanceArgContextResolverCallsCount = 0
    var makeInstanceArgContextResolverCalled: Bool {
        return makeInstanceArgContextResolverCallsCount > 0
    }

    var makeInstanceArgContextResolverReceivedArguments: (arg: Any, context: Any, resolver: Resolver)?
    var makeInstanceArgContextResolverReceivedInvocations: [(arg: Any, context: Any, resolver: Resolver)] = []
    var makeInstanceArgContextResolverReturnValue: Any!
    var makeInstanceArgContextResolverClosure: ((Any, Any, Resolver) throws -> Any)?

    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        if let error = makeInstanceArgContextResolverThrowableError {
            throw error
        }
        makeInstanceArgContextResolverCallsCount += 1
        makeInstanceArgContextResolverReceivedArguments = (arg: arg, context: context, resolver: resolver)
        makeInstanceArgContextResolverReceivedInvocations.append((arg: arg, context: context, resolver: resolver))
        return try makeInstanceArgContextResolverClosure.map { try $0(arg, context, resolver) } ?? makeInstanceArgContextResolverReturnValue
    }
}

class AnyResolverMock: AnyResolver {
    // MARK: - resolve

    var resolveThrowableError: Error?
    var resolveCallsCount = 0
    var resolveCalled: Bool {
        return resolveCallsCount > 0
    }

    var resolveReceivedRequest: Any?
    var resolveReceivedInvocations: [Any] = []
    var resolveReturnValue: Any!
    var resolveClosure: ((Any) throws -> Any)?

    func resolve(_ request: Any) throws -> Any {
        if let error = resolveThrowableError {
            throw error
        }
        resolveCallsCount += 1
        resolveReceivedRequest = request
        resolveReceivedInvocations.append(request)
        return try resolveClosure.map { try $0(request) } ?? resolveReturnValue
    }
}

class AnyScopeMock: AnyScope {
    var lock: Lock {
        get { return underlyingLock }
        set(value) { underlyingLock = value }
    }

    var underlyingLock: Lock!

    // MARK: - registry

    var registryForCallsCount = 0
    var registryForCalled: Bool {
        return registryForCallsCount > 0
    }

    var registryForReceivedContext: Any?
    var registryForReceivedInvocations: [Any] = []
    var registryForReturnValue: ScopeRegistry!
    var registryForClosure: ((Any) -> ScopeRegistry)?

    func registry(for context: Any) -> ScopeRegistry {
        registryForCallsCount += 1
        registryForReceivedContext = context
        registryForReceivedInvocations.append(context)
        return registryForClosure.map { $0(context) } ?? registryForReturnValue
    }
}

class AnyTypeDescriptorMock: AnyTypeDescriptor {
    var hashValue: Int {
        get { return underlyingHashValue }
        set(value) { underlyingHashValue = value }
    }

    var underlyingHashValue: Int!

    // MARK: - matches

    var matchesCallsCount = 0
    var matchesCalled: Bool {
        return matchesCallsCount > 0
    }

    var matchesReceivedOther: Any?
    var matchesReceivedInvocations: [Any] = []
    var matchesReturnValue: Bool!
    var matchesClosure: ((Any) -> Bool)?

    func matches(_ other: Any) -> Bool {
        matchesCallsCount += 1
        matchesReceivedOther = other
        matchesReceivedInvocations.append(other)
        return matchesClosure.map { $0(other) } ?? matchesReturnValue
    }
}

class BindingMock: Binding {
    // MARK: - matches

    var matchesCallsCount = 0
    var matchesCalled: Bool {
        return matchesCallsCount > 0
    }

    var matchesReceivedKey: AnyBindingKey?
    var matchesReceivedInvocations: [AnyBindingKey] = []
    var matchesReturnValue: Bool!
    var matchesClosure: ((AnyBindingKey) -> Bool)?

    func matches(_ key: AnyBindingKey) -> Bool {
        matchesCallsCount += 1
        matchesReceivedKey = key
        matchesReceivedInvocations.append(key)
        return matchesClosure.map { $0(key) } ?? matchesReturnValue
    }

    // MARK: - instance

    var instanceArgContextResolverThrowableError: Error?
    var instanceArgContextResolverCallsCount = 0
    var instanceArgContextResolverCalled: Bool {
        return instanceArgContextResolverCallsCount > 0
    }

    var instanceArgContextResolverReceivedArguments: (arg: Any, context: Any, resolver: Resolver)?
    var instanceArgContextResolverReceivedInvocations: [(arg: Any, context: Any, resolver: Resolver)] = []
    var instanceArgContextResolverReturnValue: Any!
    var instanceArgContextResolverClosure: ((Any, Any, Resolver) throws -> Any)?

    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        if let error = instanceArgContextResolverThrowableError {
            throw error
        }
        instanceArgContextResolverCallsCount += 1
        instanceArgContextResolverReceivedArguments = (arg: arg, context: context, resolver: resolver)
        instanceArgContextResolverReceivedInvocations.append((arg: arg, context: context, resolver: resolver))
        return try instanceArgContextResolverClosure.map { try $0(arg, context, resolver) } ?? instanceArgContextResolverReturnValue
    }
}

class ClosableMock: Closable {
    // MARK: - close

    var closeCallsCount = 0
    var closeCalled: Bool {
        return closeCallsCount > 0
    }

    var closeClosure: (() -> Void)?

    func close() {
        closeCallsCount += 1
        closeClosure?()
    }
}

class MatchableMock: Matchable {
    var hashValue: Int {
        get { return underlyingHashValue }
        set(value) { underlyingHashValue = value }
    }

    var underlyingHashValue: Int!

    // MARK: - matches

    var matchesCallsCount = 0
    var matchesCalled: Bool {
        return matchesCallsCount > 0
    }

    var matchesReceivedOther: Any?
    var matchesReceivedInvocations: [Any] = []
    var matchesReturnValue: Bool!
    var matchesClosure: ((Any) -> Bool)?

    func matches(_ other: Any) -> Bool {
        matchesCallsCount += 1
        matchesReceivedOther = other
        matchesReceivedInvocations.append(other)
        return matchesClosure.map { $0(other) } ?? matchesReturnValue
    }
}

class ModuleIncludeEntryMock: ModuleIncludeEntry {}

class ScopeRegistryMock: ScopeRegistry {
    // MARK: - register

    var registerForCallsCount = 0
    var registerForCalled: Bool {
        return registerForCallsCount > 0
    }

    var registerForReceivedArguments: (instance: Any, key: ScopeRegistryKey)?
    var registerForReceivedInvocations: [(instance: Any, key: ScopeRegistryKey)] = []
    var registerForClosure: ((Any, ScopeRegistryKey) -> Void)?

    func register(_ instance: Any, for key: ScopeRegistryKey) {
        registerForCallsCount += 1
        registerForReceivedArguments = (instance: instance, key: key)
        registerForReceivedInvocations.append((instance: instance, key: key))
        registerForClosure?(instance, key)
    }

    // MARK: - instance

    var instanceForCallsCount = 0
    var instanceForCalled: Bool {
        return instanceForCallsCount > 0
    }

    var instanceForReceivedKey: ScopeRegistryKey?
    var instanceForReceivedInvocations: [ScopeRegistryKey] = []
    var instanceForReturnValue: Any?
    var instanceForClosure: ((ScopeRegistryKey) -> Any?)?

    func instance(for key: ScopeRegistryKey) -> Any? {
        instanceForCallsCount += 1
        instanceForReceivedKey = key
        instanceForReceivedInvocations.append(key)
        return instanceForClosure.map { $0(key) } ?? instanceForReturnValue
    }
}
