//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyTypeManipulator {}

public protocol TypeManipulator: AnyTypeManipulator {
    associatedtype ManipulatedType
}
