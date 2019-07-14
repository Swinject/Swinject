//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyBinding {}

public protocol Binding: AnyBinding {
    associatedtype BoundType
}
