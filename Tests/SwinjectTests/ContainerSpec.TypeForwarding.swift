//
//  ContainerSpec.TypeForwarding.swift
//  Swinject
//
//  Created by Jakub Vaňo on 15/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_TypeForwarding: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("Cntainer method") {
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
    }
}
