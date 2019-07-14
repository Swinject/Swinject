//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyBinding {
    func instance(using provider: Injector) throws -> Any
}

public protocol Binding: AnyBinding {
    associatedtype BoundType
    func instance(using provider: Injector) throws -> BoundType
}

public extension AnyBinding where Self: Binding {
    func instance(using provider: Injector) throws -> Any {
        try instance(using: provider) as BoundType
    }
}
