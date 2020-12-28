//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

/// Defines a TypeIdentifier for types which can not extend `Identifiable`, such as protocols, tuples or closures
public protocol DedicatedIdentifier: TypeIdentifier {
    /// The type for which the `DedicatedIdentifier` is dedicated
    associatedtype IdentifiedType
}
