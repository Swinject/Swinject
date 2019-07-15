//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable variable_name

@testable import Swinject

class AnyBindingMock: AnyBinding {
    // MARK: - instance

    var instanceArgInjectorThrowableError: Error?
    var instanceArgInjectorCallsCount = 0
    var instanceArgInjectorCalled: Bool {
        return instanceArgInjectorCallsCount > 0
    }

    var instanceArgInjectorReceivedArguments: (arg: Any, injector: Injector)?
    var instanceArgInjectorReceivedInvocations: [(arg: Any, injector: Injector)] = []
    var instanceArgInjectorReturnValue: Any!
    var instanceArgInjectorClosure: ((Any, Injector) throws -> Any)?

    func instance(arg: Any, injector: Injector) throws -> Any {
        if let error = instanceArgInjectorThrowableError {
            throw error
        }
        instanceArgInjectorCallsCount += 1
        instanceArgInjectorReceivedArguments = (arg: arg, injector: injector)
        instanceArgInjectorReceivedInvocations.append((arg: arg, injector: injector))
        return try instanceArgInjectorClosure.map { try $0(arg, injector) } ?? instanceArgInjectorReturnValue
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
