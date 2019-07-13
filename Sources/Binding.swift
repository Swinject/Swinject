//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Binding<Type>: ModuleEntry {
    let descriptor: AnyTypeDescriptor
    let manipulator: AnyTypeManipulator
}
