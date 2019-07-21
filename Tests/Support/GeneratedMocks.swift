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

    var makeInstanceArgContextResolver3ThrowableError: Error?
    var makeInstanceArgContextResolver3CallsCount = 0
    var makeInstanceArgContextResolver3Called: Bool {
        return makeInstanceArgContextResolver3CallsCount > 0
    }

    var makeInstanceArgContextResolver3ReceivedArguments: (arg: Any, context: Any, resolver: Resolver3)?
    var makeInstanceArgContextResolver3ReceivedInvocations: [(arg: Any, context: Any, resolver: Resolver3)] = []
    var makeInstanceArgContextResolver3ReturnValue: Any!
    var makeInstanceArgContextResolver3Closure: ((Any, Any, Resolver3) throws -> Any)?

    func makeInstance(arg: Any, context: Any, resolver: Resolver3) throws -> Any {
        if let error = makeInstanceArgContextResolver3ThrowableError {
            throw error
        }
        makeInstanceArgContextResolver3CallsCount += 1
        makeInstanceArgContextResolver3ReceivedArguments = (arg: arg, context: context, resolver: resolver)
        makeInstanceArgContextResolver3ReceivedInvocations.append((arg: arg, context: context, resolver: resolver))
        return try makeInstanceArgContextResolver3Closure.map { try $0(arg, context, resolver) } ?? makeInstanceArgContextResolver3ReturnValue
    }
}

class AnyResolver3Mock: AnyResolver3 {
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

    var instanceArgContextResolver3ThrowableError: Error?
    var instanceArgContextResolver3CallsCount = 0
    var instanceArgContextResolver3Called: Bool {
        return instanceArgContextResolver3CallsCount > 0
    }

    var instanceArgContextResolver3ReceivedArguments: (arg: Any, context: Any, resolver: Resolver3)?
    var instanceArgContextResolver3ReceivedInvocations: [(arg: Any, context: Any, resolver: Resolver3)] = []
    var instanceArgContextResolver3ReturnValue: Any!
    var instanceArgContextResolver3Closure: ((Any, Any, Resolver3) throws -> Any)?

    func instance(arg: Any, context: Any, resolver: Resolver3) throws -> Any {
        if let error = instanceArgContextResolver3ThrowableError {
            throw error
        }
        instanceArgContextResolver3CallsCount += 1
        instanceArgContextResolver3ReceivedArguments = (arg: arg, context: context, resolver: resolver)
        instanceArgContextResolver3ReceivedInvocations.append((arg: arg, context: context, resolver: resolver))
        return try instanceArgContextResolver3Closure.map { try $0(arg, context, resolver) } ?? instanceArgContextResolver3ReturnValue
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

class StaticScopeRegistryMock: StaticScopeRegistry {
    // MARK: - instance

    var instanceKeyCallsCount = 0
    var instanceKeyCalled: Bool {
        return instanceKeyCallsCount > 0
    }

    var instanceKeyReceivedKey: ScopeRegistryKey?
    var instanceKeyReceivedInvocations: [ScopeRegistryKey] = []
    var instanceKeyReturnValue: Any!
    var instanceKeyClosure: ((ScopeRegistryKey) -> Any)?

    func instance(key: ScopeRegistryKey) -> Any {
        instanceKeyCallsCount += 1
        instanceKeyReceivedKey = key
        instanceKeyReceivedInvocations.append(key)
        return instanceKeyClosure.map { $0(key) } ?? instanceKeyReturnValue
    }

    // MARK: - clear

    var clearCallsCount = 0
    var clearCalled: Bool {
        return clearCallsCount > 0
    }

    var clearClosure: (() -> Void)?

    func clear() {
        clearCallsCount += 1
        clearClosure?()
    }
}
