// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


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

    //MARK: - matches

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
        return matchesClosure.map({ $0(other) }) ?? matchesReturnValue!
    }

}
class AnyBindningMakerMock: AnyBindningMaker {

    //MARK: - makeBinding

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
        return makeBindingForClosure.map({ $0(descriptor) }) ?? makeBindingForReturnValue!
    }

}
class AnyContextTranslatorMock: AnyContextTranslator {
    var sourceType: Any.Type {
        get { return underlyingSourceType }
        set(value) { underlyingSourceType = value }
    }
    var underlyingSourceType: Any.Type!
    var targetType: Any.Type {
        get { return underlyingTargetType }
        set(value) { underlyingTargetType = value }
    }
    var underlyingTargetType: Any.Type!

    //MARK: - translate

    var translateThrowableError: Error?
    var translateCallsCount = 0
    var translateCalled: Bool {
        return translateCallsCount > 0
    }
    var translateReceivedContext: Any?
    var translateReceivedInvocations: [Any] = []
    var translateReturnValue: Any!
    var translateClosure: ((Any) throws -> Any)?

    func translate(_ context: Any) throws -> Any {
        if let error = translateThrowableError {
            throw error
        }
        translateCallsCount += 1
        translateReceivedContext = context
        translateReceivedInvocations.append(context)
        return try translateClosure.map({ try $0(context) }) ?? translateReturnValue!
    }

}
class AnyInstanceMakerMock: AnyInstanceMaker {

    //MARK: - makeInstance

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
        return try makeInstanceArgContextResolverClosure.map({ try $0(arg, context, resolver) }) ?? makeInstanceArgContextResolverReturnValue!
    }

}
class AnyResolverMock: AnyResolver {

    //MARK: - resolve

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
        return try resolveClosure.map({ try $0(request) }) ?? resolveReturnValue!
    }

}
class AnyScopeMock: AnyScope {
    var contextType: Any.Type {
        get { return underlyingContextType }
        set(value) { underlyingContextType = value }
    }
    var underlyingContextType: Any.Type!

    //MARK: - registry

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
        return registryForClosure.map({ $0(context) }) ?? registryForReturnValue!
    }

}
class AnyTypeDescriptorMock: AnyTypeDescriptor {

    //MARK: - matches

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
        return matchesClosure.map({ $0(other) }) ?? matchesReturnValue!
    }

    //MARK: - hash

    var hashIntoCallsCount = 0
    var hashIntoCalled: Bool {
        return hashIntoCallsCount > 0
    }
    var hashIntoReceivedHasher: Hasher?
    var hashIntoReceivedInvocations: [Hasher] = []
    var hashIntoClosure: ((inout Hasher) -> Void)?

    func hash(into hasher: inout Hasher) {
        hashIntoCallsCount += 1
        hashIntoReceivedHasher = hasher
        hashIntoReceivedInvocations.append(hasher)
        hashIntoClosure?(&hasher)
    }

}
class BindingMock: Binding {

    //MARK: - matches

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
        return matchesClosure.map({ $0(key) }) ?? matchesReturnValue!
    }

    //MARK: - instance

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
        return try instanceArgContextResolverClosure.map({ try $0(arg, context, resolver) }) ?? instanceArgContextResolverReturnValue!
    }

}
class ClosableMock: Closable {

    //MARK: - close

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

    //MARK: - matches

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
        return matchesClosure.map({ $0(other) }) ?? matchesReturnValue!
    }

    //MARK: - hash

    var hashIntoCallsCount = 0
    var hashIntoCalled: Bool {
        return hashIntoCallsCount > 0
    }
    var hashIntoReceivedHasher: Hasher?
    var hashIntoReceivedInvocations: [Hasher] = []
    var hashIntoClosure: ((inout Hasher) -> Void)?

    func hash(into hasher: inout Hasher) {
        hashIntoCallsCount += 1
        hashIntoReceivedHasher = hasher
        hashIntoReceivedInvocations.append(hasher)
        hashIntoClosure?(&hasher)
    }

}
class ModuleIncludeEntryMock: ModuleIncludeEntry {

}
class StaticScopeRegistryMock: StaticScopeRegistry {

    //MARK: - instance

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
        return instanceKeyClosure.map({ $0(key) }) ?? instanceKeyReturnValue!
    }

    //MARK: - clear

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










