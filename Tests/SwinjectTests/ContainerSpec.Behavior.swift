//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
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
            it("should be invoked using proper type") {
                let spy = BehaviorSpy()
                container.addBehavior(spy)

                container.register(Animal.self) { _ in Dog() }

                expect(spy.types.first == Animal.self).to(beTrue())
            }
        }
        describe("forwarding service") {
            it("should be invoked") {
                let spy1 = BehaviorSpy()
                let spy2 = BehaviorSpy()
                container.addBehavior(spy1)
                container.addBehavior(spy2)

                container.register(Dog.self) { _ in Dog() }
                    .implements(Animal.self)

                expect(spy1.entries).to(haveCount(2))
                expect(spy2.entries).to(haveCount(2))
            }
            it("should be invoked using proper name") {
                let spy = BehaviorSpy()
                container.addBehavior(spy)

                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                    .implements(Animal.self)

                expect(spy.names[0]).to(equal("Hachi"))
                expect(spy.names[1]).to(beNil())
            }
            it("should be invoked using proper type") {
                let spy = BehaviorSpy()
                container.addBehavior(spy)

                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                    .implements(Animal.self)

                expect(spy.types[0] == Dog.self).to(beTrue())
                expect(spy.types[1] == Animal.self).to(beTrue())
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
