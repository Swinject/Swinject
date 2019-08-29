//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class InjectionSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    describe("instance") {
        it("throws if bound type has missing dependency") {
            let swinject = Swinject {
                register().factory { Pet(owner: try instance().from($0)) }
            }
            expect { try instance(of: Pet.self).from(swinject) }.to(throwError())
        }
        it("injects instance if all dependencies are bound") {
            let john = Human()
            let swinject = Swinject {
                register().factory { Pet(owner: try instance().from($0)) }
                register().constant(john)
            }
            expect { try instance(of: Pet.self).from(swinject).owner } === john
        }
        it("throws if type's binding requires different arguments") {
            let swinject = Swinject {
                register().factory { (_, string: String) in Int(string)! }
            }
            expect { try instance().from(swinject) as Int }.to(throwError())
            expect { try instance(arg: 42.0).from(swinject) as Int }.to(throwError())
        }
        it("rethrows error from the type's factory") {
            let swinject = Swinject {
                register().factory(for: Int.self) { throw TestError() }
            }
            expect { try instance(of: Int.self).from(swinject) }.to(throwError(errorType: TestError.self))
        }
    }
    #endif
} }
