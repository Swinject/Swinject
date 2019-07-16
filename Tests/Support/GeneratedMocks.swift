//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable variable_name

@testable import Swinject

class AnyBindingMock: AnyBinding {
    // MARK: - instance

    var instanceArgResolverThrowableError: Error?
    var instanceArgResolverCallsCount = 0
    var instanceArgResolverCalled: Bool {
        return instanceArgResolverCallsCount > 0
    }

    var instanceArgResolverReceivedArguments: (arg: Any, resolver: Resolver)?
    var instanceArgResolverReceivedInvocations: [(arg: Any, resolver: Resolver)] = []
    var instanceArgResolverReturnValue: Any!
    var instanceArgResolverClosure: ((Any, Resolver) throws -> Any)?

    func instance(arg: Any, resolver: Resolver) throws -> Any {
        if let error = instanceArgResolverThrowableError {
            throw error
        }
        instanceArgResolverCallsCount += 1
        instanceArgResolverReceivedArguments = (arg: arg, resolver: resolver)
        instanceArgResolverReceivedInvocations.append((arg: arg, resolver: resolver))
        return try instanceArgResolverClosure.map { try $0(arg, resolver) } ?? instanceArgResolverReturnValue
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
    var descriptor: AnyTypeDescriptor {
        get { return underlyingDescriptor }
        set(value) { underlyingDescriptor = value }
    }

    var underlyingDescriptor: AnyTypeDescriptor!
    var argumentType: Any.Type {
        get { return underlyingArgumentType }
        set(value) { underlyingArgumentType = value }
    }

    var underlyingArgumentType: Any.Type!

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
