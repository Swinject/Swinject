//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import class Swinject.UnboundScope

class SingletonSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    beforeEach {
        UnboundScope.root.close()
    }
    it("never reuses instances from a simple binding") {
        let swinject = Swinject {
            register().factory { Human() }
        }
        let first = try? instance(of: Human.self).from(swinject)
        let second = try? instance(of: Human.self).from(swinject)
        expect(first) !== second
    }
    it("injects the same instance from a singleton binding") {
        let swinject = Swinject {
            registerSingle().factory { Human() }
        }
        let first = try? instance(of: Human.self).from(swinject)
        let second = try? instance(of: Human.self).from(swinject)
        expect(first) === second
    }
    it("injects the same instance for types bound to the same implementation") {
        let swinject = Swinject {
            registerSingle()
                .factory { Human() }
                .alsoUse { $0 as Mammal }
        }
        let human = try? instance().from(swinject) as Human
        let mammal = try? instance().from(swinject) as Mammal
        expect(human) === mammal
    }
    it("does not reuse singleton instances for different tags") {
        let swinject = Swinject {
            registerSingle().factory(tag: "john") { Human() }
            registerSingle().factory(tag: "rick") { Human() }
        }
        let john = try? instance(of: Human.self, tagged: "john").from(swinject)
        let rick = try? instance(of: Human.self, tagged: "rick").from(swinject)
        expect(john) !== rick
    }
    it("injects the same instance from multiton binding when using the same argument") {
        let swinject = Swinject {
            register().factory { Human() }
            registerSingle().factory { Pet(name: $1, owner: try instance().from($0)) }
        }
        let first = try? instance(of: Pet.self, arg: "mimi").from(swinject)
        let second = try? instance(of: Pet.self, arg: "mimi").from(swinject)
        expect(first) === second
    }
    it("injects a different instance from multiton binding when using a different argument") {
        let swinject = Swinject {
            register().factory { Human() }
            registerSingle().factory { Pet(name: $1, owner: try instance().from($0)) }
        }
        let mimi = try? instance(of: Pet.self, arg: "mimi").from(swinject)
        let riff = try? instance(of: Pet.self, arg: "riff").from(swinject)
        expect(mimi) !== riff
    }
    describe("weak reference") {
        it("it releases instance if it is not used") {
            let swinject = Swinject {
                registerSingle()
                    .factory { Human() }
                    .withProperties { $0.reference = weakRef }
            }
            weak var first = try? instance().from(swinject) as Human
            expect(first).to(beNil())
        }
        it("injects the same instance while it is used") {
            let swinject = Swinject {
                registerSingle()
                    .factory { Human() }
                    .withProperties { $0.reference = weakRef }
            }
            let first = try? instance(of: Human.self).from(swinject)
            let second = try? instance(of: Human.self).from(swinject)
            expect(first) === second
        }
    }
    #endif
} }
