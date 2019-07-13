//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Binding<BaseType> {
    let descriptor: AnyTypeDescriptor
    let manipulator: AnyTypeManipulator
}
