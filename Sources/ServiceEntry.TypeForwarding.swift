//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension ServiceEntry {
    /// Adds another type which should be resolved using this ServiceEntry - i.e. using the same object scope,
    /// arguments and `initCompleted` closures
    ///
    /// - Parameters:
    ///     - type: Type resolution of which should be forwarded
    ///     - name: A registration name, which is used to differentiate from other registrations of the same `type`
    @discardableResult
    public func implements<T>(_ type: T.Type, name: String? = nil) -> ServiceEntry<Service> {
        container?.forward(type, name: name, to: self)
        return self
    }

    /// Adds multiple types which should be resolved using this ServiceEntry - i.e. using the same object scope,
    /// arguments and `initCompleted` closures
    ///
    /// - Parameters:
    ///     - types: Types resolution of which should be forwarded
    @discardableResult
    public func implements<each T>(_ types: repeat (each T).Type) -> ServiceEntry<Service> {
        repeat (container?.forward(each types, name: nil, to: self))
        return self
    }
}
