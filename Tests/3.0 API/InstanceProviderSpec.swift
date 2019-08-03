//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class InstanceProviderSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    describe("Lazy") {
        it("can inject lazy provider of a bound type") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            var lazyInt = try? swinject.instance() as Lazy<Int>
            expect { lazyInt?.instance } == 42
        }
        it("throws if provided type is not bound") {
            let swinject = Swinject {}
            expect { try swinject.instance() as Lazy<Int> }.to(throwError())
        }
        it("throws if provided type is bound with different arguments") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            expect { try swinject.instance(arg: "arg") as Lazy<Int> }.to(throwError())
        }
        it("can inject lazy provider of bound type with arguments") {
            let swinject = Swinject {
                bbind(Int.self) & factory { Int($1 as String)! }
            }
            var lazyInt = try? swinject.instance(arg: "42") as Lazy<Int>
            expect { lazyInt?.instance } == 42
        }
        it("throws if provided type is bound with different tag") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            expect { try swinject.instance(tagged: "tag") as Lazy<Int> }.to(throwError())
        }
        it("can inject lazy provider of tagged bound type") {
            let swinject = Swinject {
                bbind(Int.self, tagged: "tag") & 42
            }
            var lazyInt = try? swinject.instance(tagged: "tag") as Lazy<Int>
            expect { lazyInt?.instance } == 42
        }
        it("can use lazy as a property wrapper") {
            struct IntHolder {
                @Lazy var int: Int
            }
            let swinject = Swinject {
                bbind(Int.self) & 42
                bbind(IntHolder.self) & provider { IntHolder(int: try $0.instance()) }
            }
            var holder = try? swinject.instance(of: IntHolder.self)
            expect { holder?.int } == 42
        }
        it("does not invoke value builder until lazy value is accessed") {
            var invoked = false
            struct IntHolder {
                @Lazy var int: Int
            }
            let swinject = Swinject {
                bbind(Int.self) & provider { invoked = true; return 42 }
                bbind(IntHolder.self) & provider { IntHolder(int: try $0.instance()) }
            }
            _ = try? swinject.instance(of: IntHolder.self)
            expect(invoked) == false
        }
    }
    #endif
} }
