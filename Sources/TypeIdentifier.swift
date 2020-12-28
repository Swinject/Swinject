//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

/// Identifier binding typed identification with string based name identification in a `Container`
public protocol TypeIdentifier {
    var rawValue: String { get }
}
