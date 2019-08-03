//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// Wrapper to enable delayed dependency instantiation.
/// `Lazy<Type>` does not need to be explicitly registered into the `Container` - resolution will work
/// as long as there is a registration for the `Type`.
@propertyWrapper public enum Lazy<Value>: PropertyWrapper {
    /// Getter for the wrapped object.
    /// It will be resolved from the `Container` when first accessed, all other calls will return the same instance.
    public var instance: Value {
        mutating get { return wrappedValue }
    }

    case uninitialized(() -> Value)
    case initialized(Value)

    public init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }

    public var wrappedValue: Value {
        mutating get {
            switch self {
            case let .uninitialized(initializer):
                let value = initializer()
                self = .initialized(value)
                return value
            case let .initialized(value):
                return value
            }
        }
        set {
            self = .initialized(newValue)
        }
    }
}

/// Wrapper to enable delayed dependency instantiation.
/// `Provider<Type>` does not need to be explicitly registered into the `Container` - resolution will work
/// as long as there is a registration for the `Type`.
@propertyWrapper public struct Provider<Type>: PropertyWrapper {
    /// Getter for the wrapped object.
    /// New instance will be resolved from the `Container` every time it is accessed.
    public var instance: Type {
        return wrappedValue
    }

    private let provider: () -> Type

    public init(wrappedValue: @autoclosure @escaping () -> Type) {
        provider = wrappedValue
    }

    public var wrappedValue: Type {
        return provider()
    }
}
