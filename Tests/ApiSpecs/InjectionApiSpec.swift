//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class InjectionApiSpec: QuickSpec { override func spec() {
    var person = Person()
    beforeEach {
        person = Person()
    }
    it("returns instance if is bound") {
        let swinject = Swinject {
            bbind(Int.self).with(42)
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("can infer the requested type") {
        let swinject = Swinject {
            bbind(Int.self) & 42
        }
        expect { try swinject.instance() as Int } == 42
    }
    it("throws if providing type with missing dependency") {
        let swinject = Swinject {
            bbind(Pet.self) & provider { Pet(owner: try $0.instance()) }
        }
        expect { try swinject.instance(of: Pet.self) }.to(throwError())
    }
    it("returns instance if all dependencies are bound") {
        let swinject = Swinject {
            bbind(Pet.self) & provider { Pet(owner: try $0.instance()) }
            bbind(Person.self) & instance(person)
        }
        expect { try swinject.instance(of: Pet.self).owner } === person
    }
    it("throws if has multiple bindings for the same request") {
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
    it("returns instance with correct tag") {
        let swinject = Swinject {
            bbind(String.self) & "Plain"
            bbind(String.self, tagged: "Tag") & "Tagged"
        }
        expect { try swinject.instance(of: String.self) } == "Plain"
        expect { try swinject.instance(of: String.self, tagged: "Tag") } == "Tagged"
    }
    it("can inject instance provider") {
        let swinject = Swinject {
            bbind(Int.self, tagged: "tag") & 42
        }
        let provider = swinject.provider(of: Int.self, tagged: "tag")
        expect { try provider() } == 42
    }
    it("can inject instance factory") {
        // FIXME: compiler segfaults if declaring this factory inside function builder
        let intFactory = factory { (r, arg: Int) in Int(try r.instance() as Double) + 5 * arg }
        let swinject = Swinject {
            bbind(Double.self) & 17.0
            bbind(Int.self) & intFactory
        }
        let factory = swinject.factory() as (Int) throws -> Int
        expect { try factory(5) } == 42
    }
    it("can inject factory binding as provider or instance") {
        let swinject = Swinject {
            bbind(Double.self) & 17.0
            bbind(Int.self) & factory { Int(try $0.instance() as Double) + 5 * $1 }
        }
        expect { try swinject.provider(of: Int.self, arg: 5)() } == 42
        expect { try swinject.instance(of: Int.self, arg: 5) } == 42
    }
    it("can curry factory's arguments") {
        let swinject = Swinject {
            bbind(Int.self) & factory { (_, a1: Int, a2: Double, a3: String) in
                a1 + Int(a2) + Int(a3)!
            }
        }
        expect { try swinject.factory(of: Int.self)(11, 14.0, "17") } == 42
        expect { try swinject.factory(of: Int.self, arg: 11)(14.0, "17") } == 42
        expect { try swinject.factory(of: Int.self, args: 11, 14.0)("17") } == 42
    }
    it("can pass context to the bindings") {
        // FIXME: compiler segfaults if declaring these providers inside function builder
        let intProvider = contexted(String.self).provider { _, string in Int(string)! }
        let doubleProvider = contexted(String.self).provider { _, string in Double(string)! }
        let swinject = Swinject {
            bbind(Int.self) & intProvider
            bbind(Double.self) & doubleProvider
        }
        let contexted = swinject.on("42")
        expect { try contexted.instance(of: Int.self) } == 42
        expect { try contexted.instance(of: Double.self) } == 42
        expect { try swinject.instance(of: Int.self) }.to(throwError())
    }
    it("can use binding without context in any context") {
        let swinject = Swinject {
            bbind(Int.self) & 42
        }
        expect { try swinject.on("context").instance() as Int } == 42
        expect { try swinject.on(Person()).instance() as Int } == 42
    }
} }
