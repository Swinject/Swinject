//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import class Swinject.UnboundScope

class SwinjectApiSpec: QuickSpec { override func spec() {
    var human = Human()
    beforeEach {
        UnboundScope.root.close()
        human = Human()
    }
    it("returns instance if is bound") {
        let swinject = Swinject(
            bbind(Int.self).with(42)
        )
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("can infer the requested type") {
        let swinject = Swinject(
            bbind(Int.self) & 42
        )
        expect { try swinject.instance() as Int } == 42
    }
    it("throws if providing type with missing dependency") {
        let swinject = Swinject(
            bbind(Pet.self) & provider { Pet(owner: try $0.instance()) }
        )
        expect { try swinject.instance(of: Pet.self) }.to(throwError())
    }
    it("returns instance if all dependencies are bound") {
        let swinject = Swinject(
            bbind(Pet.self) & provider { Pet(owner: try $0.instance()) },
            bbind(Human.self) & instance(human)
        )
        expect { try swinject.instance(of: Pet.self).owner } === human
    }
    it("throws if has multiple bindings for the same request") {
        let swinject = Swinject(
            bbind(Int.self) & 42,
            bbind(Int.self) & provider { 17 + 25 }
        )
        expect { try swinject.instance(of: Int.self) }.to(throwError())
    }
    it("throws if requesting instance with wrong tag") {
        let swinject = Swinject(
            bbind(Int.self, tagged: "Tag") & 42
        )
        expect { try swinject.instance(of: Int.self) }.to(throwError())
        expect { try swinject.instance(of: Int.self, tagged: 42) }.to(throwError())
        expect { try swinject.instance(of: Int.self, tagged: "OtherTag") }.to(throwError())
    }
    it("returns instance with correct tag") {
        let swinject = Swinject(
            bbind(String.self) & "Plain",
            bbind(String.self, tagged: "Tag") & "Tagged"
        )
        expect { try swinject.instance(of: String.self) } == "Plain"
        expect { try swinject.instance(of: String.self, tagged: "Tag") } == "Tagged"
    }
    it("can bind protocol to implementation") {
        let swinject = Swinject(
            bbind(Mammal.self).with(provider { Human() })
        )
        expect(try? swinject.instance(of: Mammal.self) is Human) == true
    }
    it("can inject optionals") {
        let swinject = Swinject(
            bbind(Int.self) & 42
        )
        expect { try swinject.instance() as Int? } == 42
    }
    it("can inject instance provider") {
        let swinject = Swinject(
            bbind(Int.self, tagged: "tag") & 42
        )
        let provider = swinject.provider(of: Int.self, tagged: "tag")
        expect { try provider() } == 42
    }
    it("can inject instance factory") {
        let swinject = Swinject(
            bbind(Double.self) & 17.0,
            bbind(Int.self) & factory { (r, arg: Int) in
                Int(try r.instance() as Double) + 5 * arg
            }
        )
        let factory = swinject.factory() as (Int) throws -> Int
        expect { try factory(5) } == 42
    }
    it("can inject factory binding as provider or instance") {
        let swinject = Swinject(
            bbind(Double.self) & 17.0,
            bbind(Int.self) & factory { Int(try $0.instance() as Double) + 5 * $1 }
        )
        expect { try swinject.provider(of: Int.self, arg: 5)() } == 42
        expect { try swinject.instance(of: Int.self, arg: 5) } == 42
    }
    it("can curry factory's arguments") {
        let swinject = Swinject(
            bbind(Int.self) & factory { (_, a1: Int, a2: Double, a3: String) in
                a1 + Int(a2) + Int(a3)!
            }
        )
        expect { try swinject.factory(of: Int.self)(11, 14.0, "17") } == 42
        expect { try swinject.factory(of: Int.self, arg: 11)(14.0, "17") } == 42
        expect { try swinject.factory(of: Int.self, arg: 11, 14.0)("17") } == 42
    }
    it("can pass context to the bindings") {
        let swinject = Swinject(
            bbind(Int.self) & contexted(String.self).provider { _, string in Int(string)! },
            bbind(Double.self) & contexted(String.self).provider { _, string in Double(string)! }
        )
        let contexted = swinject.on("42")
        expect { try contexted.instance(of: Int.self) } == 42
        expect { try contexted.instance(of: Double.self) } == 42
        expect { try swinject.instance(of: Int.self) }.to(throwError())
    }
    it("can use binding without context in any context") {
        let swinject = Swinject(
            bbind(Int.self) & 42
        )
        expect { try swinject.on("context").instance() as Int } == 42
        expect { try swinject.on(Human()).instance() as Int } == 42
    }
    it("can translate contexts") {
        let swinject = Swinject(
            bbind(Int.self) & contexted(String.self).provider { _, string in Int(string)! },
            bbind(Double.self) & contexted(Int.self).provider { _, int in Double(int) },
            registerContextTranslator(from: String.self) { Int($0)! }
        )
        let contexted = swinject.on("42")
        expect { try contexted.instance(of: Int.self) } == 42
        expect { try contexted.instance(of: Double.self) } == 42
    }
    it("can bind singleton") {
        let swinject = Swinject(
            bbind(Human.self) & singleton { Human() }
        )
        let first = try? swinject.instance() as Human
        let second = try? swinject.instance() as Human
        expect(first) === second
    }
    it("can bind scoped singleton") {
        let scope = UnboundScope()
        let swinject = Swinject(
            bbind(Human.self) & scoped(scope).singleton { Human() }
        )
        let first = try? swinject.instance() as Human
        let second = try? swinject.instance() as Human
        expect(first) === second
    }
    it("can close scopes") {
        let scope = UnboundScope()
        let swinject = Swinject(
            bbind(Human.self) & scoped(scope).singleton { Human() }
        )
        let first = try? swinject.instance() as Human
        scope.close()
        let second = try? swinject.instance() as Human
        expect(first) !== second
    }
    it("notifies instances when scope is closed") {
        let scope = UnboundScope()
        let swinject = Swinject(
            bbind(ClosableMock.self) & scoped(scope).singleton { ClosableMock() }
        )
        let closable = try? swinject.instance() as ClosableMock
        scope.close()
        expect(closable?.closeCalled) == true
    }
    it("can bind weakly referenced singleton") {
        let swinject = Swinject(
            bbind(Human.self) & singleton(ref: weakRef) { Human() }
        )
        weak var first = try? swinject.instance() as Human
        expect(first).to(beNil())
    }
    it("can bind multitons") {
        let swinject = Swinject(
            bbind(Building.self) & multiton { Building(floors: $1) }
        )
        let house1 = try? swinject.instance(arg: 1) as Building
        let house2 = try? swinject.instance(arg: 1) as Building
        let skyscrapper = try? swinject.instance(arg: 100) as Building
        expect(house1) === house2
        expect(skyscrapper) !== house1
    }
} }
