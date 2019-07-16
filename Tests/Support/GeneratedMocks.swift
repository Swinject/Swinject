//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable variable_name

@testable import Swinject

class AnyBindingMock: AnyBinding {
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

class AnyBindingEntryMock: AnyBindingEntry {
    var key: AnyBindingKey {
        get { return underlyingKey }
        set(value) { underlyingKey = value }
    }

    var underlyingKey: AnyBindingKey!
    var binding: AnyBinding {
        get { return underlyingBinding }
        set(value) { underlyingBinding = value }
    }

    var underlyingBinding: AnyBinding!
}

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
