//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class OverrideSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("does not allow multiple bindings for the same type") {
        expect {
            _ = Swinject {
                bbind(Int.self) & 42
                bbind(Int.self) & provider { 25 + 17 }
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow bindings for type and it's optional") {
        expect {
            _ = Swinject {
                bbind(Int?.self) & 42
                bbind(Int.self) & provider { 25 + 17 }
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow multiple bindings for the same type in a module hierarchy") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 42
        }
        expect {
            _ = Swinject {
                include(firstModule)
                bbind(Int.self) & provider { 25 + 17 }
            }
        }.ifDebugTo(throwAssertion())
    }
    it("can declare that binding overrides previous binding for the same type") {
        let swinject = Swinject {
            bbind(Int.self) & 0
            bbind(Int.self, overrides: true) & 42
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("uses the last overriding binding for the injection") {
        let swinject = Swinject {
            bbind(Int.self) & 1
            bbind(Int.self, overrides: true) & 2
            bbind(Int.self, overrides: true) & 42
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("must declare overriding binding after the overriden one") {
        expect {
            _ = Swinject {
                bbind(Int.self, overrides: true) & 42
                bbind(Int.self) & 0
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow overriding binding if there is nothing to override") {
        expect {
            _ = Swinject {
                bbind(Int.self, overrides: true) & 42
            }
        }.ifDebugTo(throwAssertion())
    }
    #endif
} }
