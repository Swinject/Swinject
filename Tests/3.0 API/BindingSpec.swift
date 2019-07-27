//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class BindingSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can define a binding for a type") {
        let swinject = Swinject {
            bbind(Int.self).with(42)
            bbind(Double.self) & 42.0
        }
        expect { try swinject.instance() as Int } == 42
        expect { try swinject.instance() as Double } == 42
    }
    it("does not allow multiple bindings for the same type") {
        let swinject = Swinject {
            bbind(Int.self).with(42)
            bbind(Int.self) & 27
        }
        expect { try swinject.instance() as Int }.to(throwError())
    }
    it("can bind the same type with different tags") {
        let swinject = Swinject {
            bbind(String.self) & "Plain"
            bbind(String.self, tagged: "Tag") & "Tagged"
            bbind(String.self, tagged: 42) & "42"
        }
        expect { try swinject.instance(of: String.self) } == "Plain"
        expect { try swinject.instance(of: String.self, tagged: "Tag") } == "Tagged"
        expect { try swinject.instance(of: String.self, tagged: 42) } == "42"
    }
    it("throws if has no binding with given tag") {
        let swinject = Swinject {
            bbind(String.self) & "Plain"
            bbind(String.self, tagged: "Tag") & "Tagged"
        }
        expect { try swinject.instance(of: String.self, tagged: "WrongTag") }.to(throwError())
    }
    it("can bind a protocol to it's implementation") {
        let swinject = Swinject {
            bbind(Mammal.self).with(provider { Human() })
        }
        expect(try? swinject.instance(of: Mammal.self) is Human) == true
    }
    #endif
} }
