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
            it("resolves forwarded type given correct name") {
                let service = container.register(Dog.self) { _ in Dog() }
                container.forward(Animal.self, name: "Hachi", to: service)

                let animal = container.resolve(Animal.self, name: "Hachi")

                expect(animal).notTo(beNil())
            }
            it("does not resolve forwarded type given incorrect name") {
                let service = container.register(Dog.self) { _ in Dog() }
                container.forward(Animal.self, name: "Hachi", to: service)

                let animal = container.resolve(Animal.self, name: "Mimi")

                expect(animal).to(beNil())
            }
            it("does not resolve when forwarding incompatible types") {
                let service = container.register(Dog.self) { _ in Dog() }
                container.forward(Cat.self, to: service)

                let cat = container.resolve(Cat.self)

                expect(cat).to(beNil())
            }
            it("does not resolve when forwarding incompatible types with arguments") {
                let service = container.register(Dog.self) { (_, _: String) in Dog() }
                container.forward(Cat.self, to: service)

                let cat = container.resolve(Cat.self, argument: "")

                expect(cat).to(beNil())
            }
            it("resolves forwarded type even if only implementation type conforms to it") {
                let service = container.register(Animal.self) { _ in Dog() }
                container.forward(Dog.self, to: service)
                let dog = container.resolve(Dog.self)
                expect(dog).notTo(beNil())
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
            it("resolves forwarded types only when correct name is given") {
                container.register(Dog.self) { _ in Dog() }
                    .implements(DogProtocol1.self, name: "1")
                    .implements(DogProtocol2.self, name: "2")
                    .implements(DogProtocol3.self, name: "3")

                let dog1 = container.resolve(DogProtocol1.self, name: "1")
                let dog2 = container.resolve(DogProtocol2.self)
                let dog3 = container.resolve(DogProtocol3.self, name: "2")

                expect(dog1).notTo(beNil())
                expect(dog2).to(beNil())
                expect(dog3).to(beNil())
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
        describe("Optional resolving") {
            it("resolves optional when wrapped type is registered") {
                container.register(Dog.self) { _ in Dog() }
                let optionalDog = container.resolve(Dog?.self)
                expect(optionalDog ?? nil).notTo(beNil())
            }
            it("resolves optional to nil when wrapped type is not registered") {
                let optionalDog = container.resolve(Dog?.self)
                expect(optionalDog).notTo(beNil())
            }
            it("resolves optional with name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                let optionalDog = container.resolve(Dog?.self, name: "Hachi")
                expect(optionalDog ?? nil).notTo(beNil())
            }
            it("resolves optional to nil with wrong name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                let optionalDog = container.resolve(Dog?.self, name: "Mimi")
                expect(optionalDog ?? nil).to(beNil())
                expect(optionalDog).notTo(beNil())
            }
            it("resolves optional with arguments") {
                container.register(Dog.self) { _, name in Dog(name: name) }
                let optionalDog = container.resolve(Dog?.self, argument: "Hachi")
                expect(optionalDog ?? nil).notTo(beNil())
            }
            it("resolves optional of fowrarded type") {
                container.register(Dog.self) { _ in Dog() }.implements(Animal.self)
                let optionalAnimal = container.resolve(Animal?.self)
                let unwrappedAnimal = container.resolve(Animal?.self)
                expect(optionalAnimal ?? nil).notTo(beNil())
                expect(unwrappedAnimal ?? nil).notTo(beNil())
            }
        }
    }
}

private protocol DogProtocol1 {}
private protocol DogProtocol2 {}
private protocol DogProtocol3 {}
extension Dog: DogProtocol1, DogProtocol2, DogProtocol3 {}
