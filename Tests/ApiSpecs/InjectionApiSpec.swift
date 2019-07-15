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
    it("throws for empty swinject") {
        let swinject = Swinject {}
        expect { try swinject.instance(of: Int.self) }.to(throwError())
    }
    it("returns instance if provider is bound") {
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
    it("returns instance from bound dependency provider") {
        let swinject = Swinject {
            bbind(Pet.self) & provider { Pet(owner: try $0.instance()) }
            bbind(Person.self) & instance(person)
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
    it("returns isntance with correct tag") {
        let swinject = Swinject {
            bbind(String.self) & "Plain"
            bbind(String.self, tagged: "Tag") & "Tagged"
        }
        expect { try swinject.instance(of: String.self) } == "Plain"
        expect { try swinject.instance(of: String.self, tagged: "Tag") } == "Tagged"
    }
} }
