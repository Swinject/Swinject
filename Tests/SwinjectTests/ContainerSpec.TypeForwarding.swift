//
//  ContainerSpec.TypeForwarding.swift
//  Swinject
//
//  Created by Jakub Vaňo on 15/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//
// swiftlint:disable function_body_length

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_TypeForwarding: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("container method") {
            it("resolves forwarded type") {
                let service = container.register(Dog.self) { _ in Dog() }
                container.forward(Animal.self, to: service)

                let animal = container.resolve(Animal.self)

                expect(animal).notTo(beNil())
            }
            it("resolves forwarded type with arguments") {
                let service = container.register(Cat.self) { _, name, sleeping in Cat(name: name, sleeping: sleeping) }
                container.forward(Animal.self, to: service)

                let animal = container.resolve(Animal.self, arguments: "Mimi", true) as? Cat

                expect(animal?.name) == "Mimi"
                expect(animal?.sleeping).to(beTrue())
            }
        }
        describe("service entry method") {
            it("resolves forwarded type") {
                container.register(Dog.self) { _ in Dog() }
                    .implements(Animal.self)

                let animal = container.resolve(Animal.self)

                expect(animal).notTo(beNil())
            }
            it("suports multiple forwarding definitions") {
                container.register(Dog.self) { _ in Dog() }
                    .implements(DogProtocol1.self)
                    .implements(DogProtocol2.self)
                    .implements(DogProtocol3.self)

                let dog1 = container.resolve(DogProtocol1.self)
                let dog2 = container.resolve(DogProtocol2.self)
                let dog3 = container.resolve(DogProtocol3.self)

                expect(dog1).notTo(beNil())
                expect(dog2).notTo(beNil())
                expect(dog3).notTo(beNil())
            }
            it("supports defining multiple types at once") {
                container.register(Dog.self) { _ in Dog() }
                    .implements(DogProtocol1.self, DogProtocol2.self, DogProtocol3.self)

                let dog1 = container.resolve(DogProtocol1.self)
                let dog2 = container.resolve(DogProtocol2.self)
                let dog3 = container.resolve(DogProtocol3.self)

                expect(dog1).notTo(beNil())
                expect(dog2).notTo(beNil())
                expect(dog3).notTo(beNil())
            }
        }
    }
}

private protocol DogProtocol1 {}
private protocol DogProtocol2 {}
private protocol DogProtocol3 {}
extension Dog: DogProtocol1, DogProtocol2, DogProtocol3 {}
