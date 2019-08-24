//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class BindingSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can define a binding for a type") {
        let swinject = Swinject {
            register().constant(42)
            register().constant(42 as Double)
        }
        expect { try swinject.instance() as Int } == 42
        expect { try swinject.instance() as Double } == 42
    }
    it("can bind the same type with different tags") {
        let swinject = Swinject {
            register().constant("Plain")
            register().constant("Tagged", tag: "Tag")
        }
        expect { try swinject.instance(of: String.self) } == "Plain"
        expect { try swinject.instance(of: String.self, tagged: "Tag") } == "Tagged"
    }
    it("throws if has no binding with given tag") {
        let swinject = Swinject {
            register().constant("Plain")
            register().constant("Tagged", tag: "Tag")
        }
        expect { try swinject.instance(of: String.self, tagged: "WrongTag") }.to(throwError())
    }
    it("can bind a protocol to it's implementation") {
        let swinject = Swinject {
            register().factory(for: Mammal.self) { Human() }
        }
        expect(try? swinject.instance(of: Mammal.self) is Human) == true
    }
    it("can bind an implementation to multiple types") {
        let swinject = Swinject {
            register().factory { Human() }
                .alsoUse { $0 as Mammal }
                .alsoUse({ $0 as AnyObject }, tag: "human")
        }
        expect { try swinject.instance(of: Human.self) }.notTo(throwError())
        expect { try swinject.instance(of: Mammal.self) }.notTo(throwError())
        expect { try swinject.instance(of: AnyObject.self, tagged: "human") }.notTo(throwError())
    }
    it("can use up to 5 arguments in factory binding") {
        let swinject = Swinject {
            register().factory { (_, a1: Int) in a1 }
            register().factory { (_, a1: Int, a2: Int) in a1 + a2 }
            register().factory { (_, a1: Int, a2: Int, a3: Int) in a1 + a2 + a3 }
            register().factory { (_, a1: Int, a2: Int, a3: Int, a4: Int) in a1 + a2 + a3 + a4 }
            register().factory { (_, a1: Int, a2: Int, a3: Int, a4: Int, a5: Int) in a1 + a2 + a3 + a4 + a5 }
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
            register().factory(for: Int.self) { invoked = true; return 42 }
        }
        _ = swinject.provider(of: Int.self)
        expect(invoked) == false
    }
    it("does not invoke unnecessary bindings") {
        var invoked = false
        let swinject = Swinject {
            register().factory(for: Int.self) { invoked = true; return 42 }
            register().constant(42, tag: "tag")
        }
        _ = try? swinject.instance(of: Int.self, tagged: "tag")
        expect(invoked) == false
    }
    #endif
} }
