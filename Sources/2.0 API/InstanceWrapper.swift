//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// Wrapper to enable delayed dependency instantiation.
/// `Lazy<Type>` does not need to be explicitly registered into the `Container` - resolution will work
/// as long as there is a registration for the `Type`.
#if swift(>=5.1)
    @propertyWrapper public enum Lazy<Value>: PropertyWrapper {
        case uninitialized(() -> Value)
        case initialized(Value)

        public var wrappedValue: Value {
            mutating get { instance }
        }
    }

#else
    public enum Lazy<Value>: PropertyWrapper {
        case uninitialized(() -> Value)
        case initialized(Value)
    }
#endif

public extension Lazy {
    /// Getter for the wrapped object.
    /// It will be resolved from the `Container` when first accessed, all other calls will return the same instance.
    var instance: Value {
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

    init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
}

/// Wrapper to enable delayed dependency instantiation.
/// `Provider<Type>` does not need to be explicitly registered into the `Container` - resolution will work
/// as long as there is a registration for the `Type`.
#if swift(>=5.1)
    @propertyWrapper public struct Provider<Type>: PropertyWrapper {
        private let provider: () -> Type

        public var wrappedValue: Type {
            return instance
        }
    }

#else
    public struct Provider<Type>: PropertyWrapper {
        private let provider: () -> Type
    }
#endif

public extension Provider {
    /// Getter for the wrapped object.
    /// New instance will be resolved from the `Container` every time it is accessed.
    var instance: Type {
        return provider()
    }

    init(wrappedValue: @autoclosure @escaping () -> Type) {
        provider = wrappedValue
    }
}
