//
//  ContainerSpec.CustomStringConvertible.swift
//  Swinject
//
//  Created by Jakub Vaňo on 13/06/2017.
//  Copyright © 2017 Swinject Contributors. All rights reserved.
//
// swiftlint:disable function_body_length

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_CustomStringConvertible: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        it("describes empty description without service registrations.") {
            expect(container.description) == "[\n]"
        }
        it("describes a registration.") {
            container.register(Animal.self) { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Factory: Resolver -> Animal, ObjectScope: graph }\n"
                + "]"
        }
        it("describes a registration with name.") {
            container.register(Animal.self, name: "My Cat") { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Name: \"My Cat\", Factory: Resolver -> Animal, ObjectScope: graph }\n"
                + "]"
        }
        it("describes a registration with arguments.") {
            container.register(Animal.self) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Factory: (Resolver, String, Bool) -> Animal, ObjectScope: graph }\n"
                + "]"
        }
        it("describes a registration with a specified object scope.") {
            container.register(Animal.self) { _ in Cat() }
                .inObjectScope(.container)

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Factory: Resolver -> Animal, ObjectScope: container }\n"
                + "]"
        }
        it("describes a registration with initCompleted.") {
            container.register(Animal.self) { _ in Cat() }
                .initCompleted { _, _ in }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Factory: Resolver -> Animal, ObjectScope: graph, "
                + "InitCompleted: Specified 1 closures }\n"
                + "]"
        }
        it("describes multiple registrations.") {
            container.register(Animal.self, name: "1") { _ in Cat() }
            container.register(Animal.self, name: "2") { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Name: \"1\", Factory: Resolver -> Animal, ObjectScope: graph },\n"
                + "    { Service: Animal, Name: \"2\", Factory: Resolver -> Animal, ObjectScope: graph }\n"
                + "]"
        }
    }
}
