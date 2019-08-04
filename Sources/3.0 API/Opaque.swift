//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol AnyOpaque {
    var anyActual: Any { get }
}

protocol Opaque: AnyOpaque {
    associatedtype Actual
    var actual: Actual { get }
}

extension Opaque {
    var anyActual: Any { return actual }
}
