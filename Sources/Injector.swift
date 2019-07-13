//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Injector {
    func inject<Descriptor>(_ instance: Descriptor.BaseType, descriptor: Descriptor) throws where Descriptor: TypeDescriptor
}

public extension Injector {
    func inject<Type>(_ instance: Type) throws {
        try inject(instance, descriptor: plain(Type.self))
    }

    func inject<Type, Tag: Equatable>(_ instance: Type, tagged tag: Tag) throws {
        try inject(instance, descriptor: tagged(Type.self, with: tag))
    }
}
