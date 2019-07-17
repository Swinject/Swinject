//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable variable_name

@testable import Swinject

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

class AnyMakerEntryMock: AnyMakerEntry {
    var key: AnyMakerKey {
        get { return underlyingKey }
        set(value) { underlyingKey = value }
    }

    var underlyingKey: AnyMakerKey!
    var maker: AnyInstanceMaker {
        get { return underlyingMaker }
        set(value) { underlyingMaker = value }
    }

    var underlyingMaker: AnyInstanceMaker!
}

class AnyMakerKeyMock: AnyMakerKey {
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

    var matchesReceivedOther: AnyMakerKey?
    var matchesReceivedInvocations: [AnyMakerKey] = []
    var matchesReturnValue: Bool!
    var matchesClosure: ((AnyMakerKey) -> Bool)?

    func matches(_ other: AnyMakerKey) -> Bool {
        matchesCallsCount += 1
        matchesReceivedOther = other
        matchesReceivedInvocations.append(other)
        return matchesClosure.map { $0(other) } ?? matchesReturnValue
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

class AnyTypeDescriptorMock: AnyTypeDescriptor {
    // MARK: - matches

    var matchesCallsCount = 0
    var matchesCalled: Bool {
        return matchesCallsCount > 0
    }

    var matchesReceivedOther: AnyTypeDescriptor?
    var matchesReceivedInvocations: [AnyTypeDescriptor] = []
    var matchesReturnValue: Bool!
    var matchesClosure: ((AnyTypeDescriptor) -> Bool)?

    func matches(_ other: AnyTypeDescriptor) -> Bool {
        matchesCallsCount += 1
        matchesReceivedOther = other
        matchesReceivedInvocations.append(other)
        return matchesClosure.map { $0(other) } ?? matchesReturnValue
    }
}

class ModuleIncludeEntryMock: ModuleIncludeEntry {}
