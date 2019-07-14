//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
import Swinject

class SwinjectApiSpec: QuickSpec { override func spec() {
    var person = Person()
    beforeEach {
        person = Person()
    }
    describe("injection") {
        it("throws for empty swinject") {
            let swinject = Swinject { }
            expect { try swinject.instance(of: Int.self) }.to(throwError())
        }
        it("returns instance if provider is bound") {
            let swinject = Swinject {
                bbind(Int.self).with(42)
            }
            expect { try swinject.instance(of: Int.self) } == 42
        }
        it("throws if providing type with missing dependency") {
            let swinject = Swinject {
                bbind(Pet.self) & provider { Pet(owner: try $0.instance()) }
            }
            expect { try swinject.instance(of: Pet.self) }.to(throwError())
        }
        it("returns instance from bound dependency provider") {
            let swinject = Swinject {
                bbind(Pet.self) & provider { Pet(owner: try $0.instance()) }
                bbind(Person.self) & person
            }
            expect { try swinject.instance(of: Pet.self).owner } === person
        }
        it("throws if multiple providers are bound") {
            let swinject = Swinject {
                bbind(Int.self) & 42
                bbind(Int.self) & provider { 17 + 25 }
            }
            expect { try swinject.instance(of: Int.self) }.to(throwError())
        }
        it("throws if requesting instance with wrong tag") {
            let swinject = Swinject {
                bbind(Int.self, tagged: "Tag") & 42
            }
            expect { try swinject.instance(of: Int.self) }.to(throwError())
            expect { try swinject.instance(of: Int.self, tagged: 42) }.to(throwError())
            expect { try swinject.instance(of: Int.self, tagged: "OtherTag") }.to(throwError())
        }
        // TODO: Multiple dependencies
        // TODO: Reuse descriptor for multiple bindings?
        // TODO: Reuse binding for multiple descriptors
        // TODO: Less verbose type forwading API?
    }
}}

class Person {
    var age = 0
    var height = 0.0
    var name = ""
}

struct Pet {
    let owner: Person
}
