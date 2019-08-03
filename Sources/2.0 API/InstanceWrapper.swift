//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// Wrapper to enable delayed dependency instantiation.
/// `Lazy<Type>` does not need to be explicitly registered into the `Container` - resolution will work
/// as long as there is a registration for the `Type`.
public extension Lazy {
    /// Getter for the wrapped object.
    /// It will be resolved from the `Container` when first accessed, all other calls will return the same instance.
    var instance: Value {
        mutating get { return wrappedValue }
    }
}

/// Wrapper to enable delayed dependency instantiation.
/// `Provider<Type>` does not need to be explicitly registered into the `Container` - resolution will work
/// as long as there is a registration for the `Type`.
public final class Provider<Service> {
    /// Getter for the wrapped object.
    /// New instance will be resolved from the `Container` every time it is accessed.
    public var instance: Service {
        fatalError()
    }
}
