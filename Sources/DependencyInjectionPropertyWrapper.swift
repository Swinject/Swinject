//
//  DependencyInjectionPropertyWrapper.swift
//  Swinject
//
//  Created by Tyler Thompson on 12/17/19.
//

import Foundation
@propertyWrapper
public struct DependencyInjected<Value> {
    let name:String?
    let container:Container
    
    public init(wrappedValue value: Value? = nil, container:Container, name:String? = nil) {
        self.name = name
        self.container = container
    }

    public lazy var wrappedValue: Value? = {
        container.resolve(Value.self, name: name)
    }()
}
