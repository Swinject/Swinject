//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class OptionalsSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can use a binding for bound type's optional") {
        let swinject = Swinject {
            register().constant(42)
        }
        expect { try instance().from(swinject) as Int? } == 42
    }
    it("can use a binding of the injected type's optional") {
        let swinject = Swinject {
            register().constant(42 as Int?)
        }
        expect { try instance().from(swinject) as Int } == 42
    }
    it("throws if binding of the type's optional produces nil") {
        let swinject = Swinject {
            register().constant(nil as Int?)
        }
        expect { try instance().from(swinject) as Int }.to(throwError())
    }
    it("can use a binding for bound type's double optional") {
        let swinject = Swinject {
            register().constant(42)
        }
        expect { try instance().from(swinject) as Int?? } == 42
    }
    it("does not throw if injecting optional for an unbound type") {
        let swinject = Swinject {}
        expect { try instance().from(swinject) as Int? }.notTo(throwError())
    }
    it("throws if has an incomplete binding for the optional") {
        let swinject = Swinject {
            register().factory { Int(try instance().from($0) as Double) }
        }
        expect { try instance().from(swinject) as Int? }.to(throwError())
    }
    it("injects same singleton instance for type and it's optional") {
        let swinject = Swinject {
            registerSingle().factory { Human() }
        }
        let direct = try? instance(of: Human.self).from(swinject)
        let optional = try? instance(of: Human?.self).from(swinject)
        expect(direct) === optional
    }
    it("injects instance on the optional of a binding's context") {
        let swinject = Swinject {
            register(inContextOf: String.self).factory { try Int($0.context())! }
        }
        expect { try instance(of: Int.self).from(swinject.on("42" as String?)) } == 42
    }
    #endif
} }
