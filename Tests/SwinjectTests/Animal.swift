//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

internal protocol Animal {
    var name: String? { get set }
}

internal class Cat: Animal {
    var name: String?
    var sleeping = false
    var favoriteFood: Food?

    init() {}

    init(name: String) {
        self.name = name
    }

    init(name: String, sleeping: Bool) {
        self.name = name
        self.sleeping = sleeping
    }
}

internal class Siamese: Cat {}

internal class Dog: Animal {
    var name: String?

    init() {}

    init(name: String) {
        self.name = name
    }
}

internal struct Turtle: Animal {
    var name: String?
}
