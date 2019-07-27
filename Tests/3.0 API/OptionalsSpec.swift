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
    it("throws if has multiple bindings for optional") {
        let swinject = Swinject {
            bbind(Int.self) & 42
            bbind(Int.self) & 25
        }
        expect { try swinject.instance() as Int? }.to(throwError())
    }
    #endif
} }
