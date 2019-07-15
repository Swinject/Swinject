//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingRequest<Descriptor, Argument> where Descriptor: TypeDescriptor {
    let key: BindingKey<Descriptor, Argument>
    let argument: Argument
}
