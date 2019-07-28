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
    it("can use up to 5 arguments in factory binding") {
        let swinject = Swinject {
            bbind(Int.self) & factory { (_, a1: Int) in a1 }
            bbind(Int.self) & factory { (_, a1: Int, a2: Int) in a1 + a2 }
            bbind(Int.self) & factory { (_, a1: Int, a2: Int, a3: Int) in a1 + a2 + a3 }
            bbind(Int.self) & factory { (_, a1: Int, a2: Int, a3: Int, a4: Int) in a1 + a2 + a3 + a4 }
            bbind(Int.self) & factory { (_, a1: Int, a2: Int, a3: Int, a4: Int, a5: Int) in a1 + a2 + a3 + a4 + a5 }
        }
        expect { try swinject.instance(of: Int.self, arg: 1) } == 1
        expect { try swinject.instance(of: Int.self, arg: 1, 2) } == 3
        expect { try swinject.instance(of: Int.self, arg: 1, 2, 3) } == 6
        expect { try swinject.instance(of: Int.self, arg: 1, 2, 3, 4) } == 10
        expect { try swinject.instance(of: Int.self, arg: 1, 2, 3, 4, 5) } == 15
    }
    it("does not invoke binding until instance is required") {
        var invoked = false
        let swinject = Swinject {
            bbind(Int.self) & provider { invoked = true; return 42 }
        }
        _ = swinject.provider(of: Int.self)
        expect(invoked) == false
    }
    it("does not invoke unnecessary bindings") {
        var invoked = false
        let swinject = Swinject {
            bbind(Int.self) & provider { invoked = true; return 42 }
            bbind(Int.self, tagged: "tag") & 42
        }
        _ = try? swinject.instance(of: Int.self, tagged: "tag")
        expect(invoked) == false
    }
    #endif
} }
