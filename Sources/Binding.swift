//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyBinding {
    func instance(using injector: Injector) throws -> Any
}

public protocol Binding: AnyBinding {
    associatedtype BoundType
    associatedtype Argument
    func instance(using injector: Injector) throws -> BoundType
}

public extension AnyBinding where Self: Binding {
    func instance(using injector: Injector) throws -> Any {
        try instance(using: injector) as BoundType
    }
}
