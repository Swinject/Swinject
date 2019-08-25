//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class ScopesSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can bind singleton on a scope without context") {
        let scope = UnboundScope()
        let swinject = Swinject {
            registerSingle(in: scope).factory { Human() }
        }
        let first = try? instance(of: Human.self).from(swinject)
        let second = try? instance(of: Human.self).from(swinject)
        expect(first) === second
    }
    it("can bind singleton on a scope with context") {
        let scope = SessionScope()
        let session = Session()
        let swinject = Swinject {
            registerSingle(in: scope).factory { Human() }
        }
        let first = try? instance(of: Human.self).from(swinject.on(session))
        let second = try? instance(of: Human.self).from(swinject.on(session))
        expect(first) === second
    }
    it("throws if injecting scoped singleton without context") {
        let scope = SessionScope()
        let swinject = Swinject {
            registerSingle(in: scope).factory { Human() }
        }
        expect { try instance(of: Human.self).from(swinject) }.to(throwError())
    }
    it("injects different intances on different contexts") {
        let scope = SessionScope()
        let swinject = Swinject {
            registerSingle(in: scope).factory { Human() }
        }
        let first = try? instance(of: Human.self).from(swinject.on(Session()))
        let second = try? instance(of: Human.self).from(swinject.on(Session()))
        expect(first) !== second
    }
    describe("closable") {
        it("can close (some) scopes") {
            let scope = UnboundScope()
            let swinject = Swinject {
                registerSingle(in: scope).factory { Human() }
            }

            let first = try? instance(of: Human.self).from(swinject)
            scope.close()
            let second = try? instance(of: Human.self).from(swinject)

            expect(first) !== second
        }
        it("notifies instances when scope is closed") {
            let scope = UnboundScope()
            let swinject = Swinject {
                registerSingle(in: scope).factory { Door() }
            }
            let door = try? instance().from(swinject) as Door

            scope.close()

            expect(door?.isClosed) == true
        }
        it("closes scoped instances when context expires") {
            let scope = SessionScope()
            var session = Session() as Session?
            let swinject = Swinject {
                registerSingle(in: scope).factory { Door() }
            }
            let door = try? instance(of: Door.self).from(swinject.on(session!))

            session = nil

            expect(door?.isClosed) == true
        }
        it("releases scoped instances when context expires") {
            let scope = SessionScope()
            var session = Session() as Session?
            let swinject = Swinject {
                registerSingle(in: scope).factory { Human() }
            }
            weak var weakInstance = try? instance(of: Human.self).from(swinject.on(session!))

            session = nil

            expect(weakInstance).to(beNil())
        }
    }
    #endif
} }
