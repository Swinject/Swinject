//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Binding<Type>: SwinjectEntry {
    let descriptor: AnyTypeDescriptor
    let manipulator: AnyTypeManipulator
}
