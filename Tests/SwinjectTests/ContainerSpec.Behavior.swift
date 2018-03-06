//
//  ContainerSpec.Behavior.swift
//  Swinject
//
//  Created by Jakub Vaňo on 16/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_Behavior: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }
        describe("adding service") {
            it("should be invoked") {
                let spy1 = BehaviorSpy()
                let spy2 = BehaviorSpy()
                container.addBehavior(spy1)
                container.addBehavior(spy2)

                container.register(Dog.self) { _ in Dog() }

                expect(spy1.entries).to(haveCount(1))
                expect(spy2.entries).to(haveCount(1))
            }
            it("should be invoked using proper name") {
                let spy = BehaviorSpy()
                container.addBehavior(spy)

                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                container.register(Cat.self) { _ in Cat() }

                expect(spy.names[0]).to(equal("Hachi"))
                expect(spy.names[1]).to(beNil())
            }
        }
        describe("convenience initialiser") {
            it("adds behaviors to the container") {
                let spy1 = BehaviorSpy()
                let spy2 = BehaviorSpy()
                container = Container(behaviors: [spy1, spy2])

                container.register(Dog.self) { _ in Dog() }

                expect(spy1.entries).to(haveCount(1))
                expect(spy2.entries).to(haveCount(1))
            }
        }
    }
}

private class BehaviorSpy: Behavior {
    var entries = [ServiceEntryProtocol]()
    var names = [String?]()

    func container<Service>(
        _ container: Container,
        didRegisterService entry: ServiceEntry<Service>,
        withName name: String?
    ) {
        entries.append(entry)
        names.append(name)
    }
}
