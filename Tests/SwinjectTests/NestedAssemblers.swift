//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import Swinject
import Foundation

struct NestedAssembly: Assembly {

    typealias ArrayType = NSMutableArray

    enum Constants {
        static let assemble = "assemble"
        static let loaded = "loaded"
    }

    struct Logger {
        let name: String
        let array = ArrayType()
    }

    let name: String
    let children: [Assembly]

    init(name: String, children: [Assembly]) {
        self.name = name
        self.children = children
    }

    func assemble(container: Container) {
        container.resolve(ArrayType.self, name: Constants.assemble)?.add(name)
    }

    func loaded(resolver: Resolver) {
        resolver.resolve(ArrayType.self, name: Constants.loaded)?.add(name)
    }
}
