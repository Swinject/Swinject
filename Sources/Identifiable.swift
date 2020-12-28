//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

public protocol Identifiable {
    /// The type of identifier used to bind type identification to string based name identification in a `Container`
    associatedtype Identifier: TypeIdentifier
}
