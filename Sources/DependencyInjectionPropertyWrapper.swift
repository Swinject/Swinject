//
//  DependencyInjectionPropertyWrapper.swift
//  Swinject
//
//  Created by Tyler Thompson on 12/17/19.
//

import Foundation
@propertyWrapper
/// Wrapper to enable lazy resolution of a type from a container.
/// Supply the container and an optional name
public struct DependencyInjected<Value> {
    ///Optional name to pass to container for resolution
    private let name:String?
    ///The container to resolve from
    private let container:Container
    
    /// init(wrappedValue: container: name): Wrapper to enable lazy resolution of a type from a container
    /// - Parameter wrappedValue: This should always be set to nil, if you do pass a value it will be ignored in favor of what is in the container
    /// - Parameter container: A `Container` the property should be resolved from
    /// - Parameter name: An optional name to pass for more specific resolution from the container.
    public init(wrappedValue value: Value? = nil, container:Container, name:String? = nil) {
        self.name = name
        self.container = container
    }

    public lazy var wrappedValue: Value? = {
        container.resolve(Value.self, name: name)
    }()
}
