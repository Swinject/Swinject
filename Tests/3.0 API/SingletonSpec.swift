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
        let first = try? swinject.instance(of: Human.self)
        let second = try? swinject.instance(of: Human.self)
        expect(first) !== second
    }
    it("injects the same instance from a singleton binding") {
        let swinject = Swinject {
            registerSingle().factory { Human() }
        }
        let first = try? swinject.instance(of: Human.self)
        let second = try? swinject.instance(of: Human.self)
        expect(first) === second
    }
    it("does not reuse singleton instances for different tags") {
        let swinject = Swinject {
            registerSingle().factory(tag: "john") { Human() }
            registerSingle().factory(tag: "rick") { Human() }
        }
        let john = try? swinject.instance(of: Human.self, tagged: "john")
        let rick = try? swinject.instance(of: Human.self, tagged: "rick")
        expect(john) !== rick
    }
    it("injects the same instance from multiton binding when using the same argument") {
        let swinject = Swinject {
            register().factory { Human() }
            registerSingle().factory { Pet(name: $1, owner: try $0.instance()) }
        }
        let first = try? swinject.instance(of: Pet.self, arg: "mimi")
        let second = try? swinject.instance(of: Pet.self, arg: "mimi")
        expect(first) === second
    }
    it("injects a different instance from multiton binding when using a different argument") {
        let swinject = Swinject {
            register().factory { Human() }
            registerSingle().factory { Pet(name: $1, owner: try $0.instance()) }
        }
        let mimi = try? swinject.instance(of: Pet.self, arg: "mimi")
        let riff = try? swinject.instance(of: Pet.self, arg: "riff")
        expect(mimi) !== riff
    }
    describe("weak reference") {
        it("it releases instance if it is not used") {
            let swinject = Swinject {
                registerSingle()
                    .factory { Human() }
                    .withProperties { $0.reference = weakRef }
            }
            weak var first = try? swinject.instance() as Human
            expect(first).to(beNil())
        }
        it("injects the same instance while it is used") {
            let swinject = Swinject {
                registerSingle()
                    .factory { Human() }
                    .withProperties { $0.reference = weakRef }
            }
            let first = try? swinject.instance(of: Human.self)
            let second = try? swinject.instance(of: Human.self)
            expect(first) === second
        }
    }
    #endif
} }
