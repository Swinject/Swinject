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
    // TODO: Refactor
    describe("function call") {
        it("can inject parameter to the function") {
            func echo(int: Int) -> Int {
                return int
            }
            let swinject = Swinject {
                register().constant(42)
            }
            expect { try swinject.call1(echo) } == 42
        }
        it("can inject multiple parameters to the function") {
            func sum(int: Int, double: Double, string: String) -> Int {
                return int + Int(double) + Int(string)!
            }
            let swinject = Swinject {
                register().constant(17)
                register().constant(14.0)
                register().constant("11")
            }
            expect { try swinject.call(sum) } == 42
        }
        it("can call initializer when declaring bindings") {
            let john = Human()
            let swinject = Swinject {
                register().constant("mimi")
                register().constant(john)
                register().factory { try $0.call(Pet.init) }
            }
            let pet = try? instance(of: Pet.self).from(swinject)
            expect(pet?.name) == "mimi"
            expect(pet?.owner) === john
        }
        it("can be used for property injection") {
            let swinject = Swinject {
                register().constant(42)
                register().constant(124 as Double)
                register().constant("john")
            }
            let john = Human()
            try? swinject.call(john.injectProperties)
            expect(john.age) == 42
            expect(john.height) == 124
            expect(john.name) == "john"
        }
    }
    #endif
} }
