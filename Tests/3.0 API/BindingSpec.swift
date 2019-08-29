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
        expect { try instance().from(swinject) as Int } == 42
        expect { try instance().from(swinject) as Double } == 42
    }
    it("can bind the same type with different tags") {
        let swinject = Swinject {
            register().constant("Plain")
            register().constant("Tagged", tag: "Tag")
        }
        expect { try instance(of: String.self).from(swinject) } == "Plain"
        expect { try instance(of: String.self, tagged: "Tag").from(swinject) } == "Tagged"
    }
    it("throws if has no binding with given tag") {
        let swinject = Swinject {
            register().constant("Plain")
            register().constant("Tagged", tag: "Tag")
        }
        expect { try instance(of: String.self, tagged: "WrongTag").from(swinject) }.to(throwError())
    }
    it("can bind a protocol to it's implementation") {
        let swinject = Swinject {
            register().factory(for: Mammal.self) { Human() }
        }
        expect(try? instance(of: Mammal.self).from(swinject) is Human) == true
    }
    it("can bind an implementation to multiple types") {
        let swinject = Swinject {
            register().factory { Human() }
                .alsoUse { $0 as Mammal }
                .alsoUse({ $0 as AnyObject }, tag: "human")
        }
        expect { try instance(of: Human.self).from(swinject) }.notTo(throwError())
        expect { try instance(of: Mammal.self).from(swinject) }.notTo(throwError())
        expect { try instance(of: AnyObject.self, tagged: "human").from(swinject) }.notTo(throwError())
    }
    it("can use up to 5 arguments in factory binding") {
        let swinject = Swinject {
            register().factory { (_, a1: Int) in a1 }
            register().factory { (_, a1: Int, a2: Int) in a1 + a2 }
            register().factory { (_, a1: Int, a2: Int, a3: Int) in a1 + a2 + a3 }
            register().factory { (_, a1: Int, a2: Int, a3: Int, a4: Int) in a1 + a2 + a3 + a4 }
            register().factory { (_, a1: Int, a2: Int, a3: Int, a4: Int, a5: Int) in a1 + a2 + a3 + a4 + a5 }
        }
        expect { try instance(of: Int.self, arg: 1).from(swinject) } == 1
        expect { try instance(of: Int.self, arg: 1, 2).from(swinject) } == 3
        expect { try instance(of: Int.self, arg: 1, 2, 3).from(swinject) } == 6
        expect { try instance(of: Int.self, arg: 1, 2, 3, 4).from(swinject) } == 10
        expect { try instance(of: Int.self, arg: 1, 2, 3, 4, 5).from(swinject) } == 15
    }
    it("does not invoke binding until instance is required") {
        var invoked = false
        _ = Swinject {
            register().factory(for: Int.self) { invoked = true; return 42 }
        }
        expect(invoked) == false
    }
    it("does not invoke unnecessary bindings") {
        var invoked = false
        let swinject = Swinject {
            register().factory(for: Int.self) { invoked = true; return 42 }
            register().constant(42, tag: "tag")
        }
        _ = try? instance(of: Int.self, tagged: "tag").from(swinject)
        expect(invoked) == false
    }
    #endif
} }
