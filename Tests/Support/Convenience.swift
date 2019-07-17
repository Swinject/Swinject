//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

extension InstanceMaker where Argument == Void, Context == Any {
    func makeInstance(resolver: Resolver) throws -> MadeType {
        try makeInstance(arg: (), context: (), resolver: resolver)
    }
}

extension InstanceMaker where Argument == Void {
    func makeInstance(context: Context, resolver: Resolver) throws -> MadeType {
        try makeInstance(arg: (), context: context, resolver: resolver)
    }
}

extension InstanceMaker where Context == Any {
    func makeInstance(arg: Argument, resolver: Resolver) throws -> MadeType {
        try makeInstance(arg: arg, context: (), resolver: resolver)
    }
}
