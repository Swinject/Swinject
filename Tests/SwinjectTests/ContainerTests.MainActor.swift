//
//  Copyright © 2024 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_MainActor: XCTestCase {

    private let container = Container()

    @MainActor
    func testRegistersMainActorFactory() {
        container.register(MainAnimal.self) { @MainActor _ in
            MainCat()
        }

        let animal = container.resolve(MainAnimal.self)
        XCTAssertNil(animal?.name)
    }

    @MainActor
    func testRegistersMainActorFactoryWithArgument() {
        container.register(MainAnimal.self) { @MainActor _, arg1 in
            MainCat(name: arg1)
        }
        let animal = container.resolve(MainAnimal.self, argument: "1")
        XCTAssertEqual(animal?.name, "1")
    }

    @MainActor
    func testRegistersMainActorFactoryWith3Arguments() {
        container.register(MainAnimal.self) { @MainActor _, arg1, arg2, arg3 in
            MainCat(name: arg1 + arg2 + arg3)
        }
        let animal = container.resolve(MainAnimal.self, arguments: "1", "2", "3")
        XCTAssertEqual(animal?.name, "123")
    }

}

@MainActor
protocol MainAnimal {
    var name: String? { get }
}

@MainActor
private class MainCat: MainAnimal {
    let name: String?

    init() {
        self.name = nil
    }

    init(name: String) {
        self.name = name
    }
}
