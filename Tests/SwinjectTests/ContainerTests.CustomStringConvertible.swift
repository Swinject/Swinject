//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_CustomStringConvertible: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    func testContainerDescribesEmptyDescriptionWithoutServiceRegistrations() {
        XCTAssertEqual(container.description, "[\n]")
    }

    func testContainerDescribesRegistration() {
        container.register(Animal.self) { _ in Cat() }

        XCTAssertEqual(container.description,
            "[\n"
            + "    { Service: Animal, Factory: Resolver -> Animal, ObjectScope: graph }\n"
            + "]")
    }

    func testContainerDescribesRegistrationWithName() {
        container.register(Animal.self, name: "My Cat") { _ in Cat() }

        XCTAssertEqual(container.description,
            "[\n"
            + "    { Service: Animal, Name: \"My Cat\", Factory: Resolver -> Animal, ObjectScope: graph }\n"
            + "]")
    }

    func testContainerDescribesRegistrationWithArguments() {
        container.register(Animal.self) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }

        XCTAssertEqual(container.description,
            "[\n"
            + "    { Service: Animal, Factory: (Resolver, String, Bool) -> Animal, ObjectScope: graph }\n"
            + "]")
    }

    func testContainerDescribesRegistrationWithSpecifiedObjectScope() {
        container.register(Animal.self) { _ in Cat() }
            .inObjectScope(.container)

        XCTAssertEqual(container.description,
            "[\n"
            + "    { Service: Animal, Factory: Resolver -> Animal, ObjectScope: container }\n"
            + "]")
    }

    func testContainerDescribesRegistrationWithInitCompleted() {
        container.register(Animal.self) { _ in Cat() }
            .initCompleted { _, _ in }

        XCTAssertEqual(container.description,
            "[\n"
            + "    { Service: Animal, Factory: Resolver -> Animal, ObjectScope: graph, "
            + "InitCompleted: Specified 1 closures }\n"
            + "]")
    }

    func testContainerDescribesMultipleRegistrations() {
        container.register(Animal.self, name: "1") { _ in Cat() }
        container.register(Animal.self, name: "2") { _ in Cat() }

        XCTAssertEqual(container.description,
            "[\n"
            + "    { Service: Animal, Name: \"1\", Factory: Resolver -> Animal, ObjectScope: graph },\n"
            + "    { Service: Animal, Name: \"2\", Factory: Resolver -> Animal, ObjectScope: graph }\n"
            + "]")
    }
}
