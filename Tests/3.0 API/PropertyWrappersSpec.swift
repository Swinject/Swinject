//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class PropertyWrappersSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    describe("any wrapper") {
        @propertyWrapper struct Wrapped<Value>: PropertyWrapper {
            var wrappedValue: Value

            public init(wrappedValue: @autoclosure @escaping () -> Value) {
                self.wrappedValue = wrappedValue()
            }
        }
        it("can inject wrapped provider of a bound type") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            let wrappedInt = try? swinject.instance() as Wrapped<Int>
            expect { wrappedInt?.wrappedValue } == 42
        }
        it("throws if provided type is not bound") {
            let swinject = Swinject {}
            expect { try swinject.instance() as Wrapped<Int> }.to(throwError())
        }
        it("throws if provided type is bound with different arguments") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            expect { try swinject.instance(arg: "arg") as Wrapped<Int> }.to(throwError())
        }
        it("can inject lazy provider of bound type with arguments") {
            let swinject = Swinject {
                bbind(Int.self) & factory { Int($1 as String)! }
            }
            let wrappedInt = try? swinject.instance(arg: "42") as Wrapped<Int>
            expect { wrappedInt?.wrappedValue } == 42
        }
        it("throws if provided type is bound with different tag") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            expect { try swinject.instance(tagged: "tag") as Wrapped<Int> }.to(throwError())
        }
        it("can inject lazy provider of tagged bound type") {
            let swinject = Swinject {
                bbind(Int.self, tagged: "tag") & 42
            }
            let wrappedInt = try? swinject.instance(tagged: "tag") as Wrapped<Int>
            expect { wrappedInt?.wrappedValue } == 42
        }
        it("can inject nested property wrappers") {
            let swinject = Swinject {
                bbind(Int.self) & 42
            }
            let doubleWrappedInt = try? swinject.instance() as Wrapped<Wrapped<Int>>
            expect { doubleWrappedInt?.wrappedValue.wrappedValue } == 42
        }
        it("can inject attributed properties") {
            struct IntHolder {
                @Wrapped var int: Int
            }
            let swinject = Swinject {
                bbind(Int.self) & 42
                bbind(IntHolder.self) & provider { try IntHolder(int: $0.instance()) }
            }
            expect { try swinject.instance(of: IntHolder.self).int } == 42
        }
    }
    #endif
} }
