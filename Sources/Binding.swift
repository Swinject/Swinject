//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyBinding {
    func instance(arg: Any, injector: Injector) throws -> Any
}

public protocol Binding: AnyBinding {
    associatedtype BoundType
    associatedtype Argument
    func instance(arg: Argument, injector: Injector) throws -> BoundType
}

public extension Binding where Argument == Void {
    func instance(injector: Injector) throws -> BoundType {
        try instance(arg: (), injector: injector)
    }
}

public extension AnyBinding where Self: Binding {
    func instance(arg: Any, injector: Injector) throws -> Any {
        guard let arg = arg as? Argument else { throw SwinjectError() }
        return try instance(arg: arg, injector: injector) as BoundType
    }
}
