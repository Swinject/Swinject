//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class OptionalsSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can use a binding for bound type's optional") {
        let swinject = Swinject {
            bbind(Int.self) & 42
        }
        expect { try swinject.instance() as Int? } == 42
    }
    // TODO: Maybe nice to have?
//    it("can use a binding of the injected type's optional") {
//        let swinject = Swinject {
//            bbind(Int?.self) & 42
//        }
//        expect { try swinject.instance() as Int } == 42
//    }
    it("throws if binding of the type's optional produces nil") {
        let swinject = Swinject {
            bbind(Int?.self) & nil
        }
        expect { try swinject.instance() as Int }.to(throwError())
    }
    it("can use a binding for bound type's double optional") {
        let swinject = Swinject {
            bbind(Int.self) & 42
        }
        expect { try swinject.instance() as Int?? } == 42
    }
    it("does not throw if injecting optional for an unbound type") {
        let swinject = Swinject {}
        expect { try swinject.instance() as Int? }.notTo(throwError())
    }
    it("throws if has an incomplete binding for the optional") {
        let swinject = Swinject {
            bbind(Int.self) & provider { Int(try $0.instance() as Double) }
        }
        expect { try swinject.instance() as Int? }.to(throwError())
    }
    it("injects same singleton instance for type and it's optional") {
        let swinject = Swinject {
            bbind(Human.self) & singleton { Human() }
        }
        let direct = try? swinject.instance(of: Human.self)
        let optional = try? swinject.instance(of: Human?.self)
        expect(direct) === optional
    }
    // TODO: Optional contexts
//    it("injects instance on the optional of a binding's context") {
//        let swinject = Swinject {
//            bbind(Int.self) & contexted(String.self).provider { (_, c: String) in Int(c)! }
//        }
//        expect { try swinject.on("42" as String?).instance(of: Int.self) } == 42
//    }
    #endif
} }
