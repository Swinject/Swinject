//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

protocol Mammal {}

class Human: Mammal {
    var age = 0
    var height = 0.0
    var name = ""

    func injectProperties(age: Int, height: Double, name: String) {
        self.age = age
        self.height = height
        self.name = name
    }
}

class Pet {
    let name: String
    let owner: Human

    init(name: String = "", owner: Human) {
        self.name = name
        self.owner = owner
    }
}

struct TestError: Error, Equatable {}

class Door: Closable {
    var closeCount = 0
    var isClosed: Bool { return closeCount > 0 }
    var whenClosed: () -> Void = {}

    func close() {
        closeCount += 1
        whenClosed()
    }
}
