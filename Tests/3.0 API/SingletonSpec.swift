//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import class Swinject.UnboundScope

class SingletonSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    beforeEach {
        UnboundScope.root.close()
    }
    it("never reuses instances from a provider binding") {
        let swinject = Swinject {
            bbind(Human.self) & provider { Human() }
        }
        let first = try? swinject.instance(of: Human.self)
        let second = try? swinject.instance(of: Human.self)
        expect(first) !== second
    }
    it("never reuses instances from a factory binding") {
        let swinject = Swinject {
            bbind(Human.self) & factory { (_, _: Int) in Human() }
        }
        let first = try? swinject.instance(of: Human.self, arg: 0)
        let second = try? swinject.instance(of: Human.self, arg: 0)
        expect(first) !== second
    }
    it("injects the same instance from a singleton binding") {
        let swinject = Swinject {
            bbind(Human.self) & singleton { Human() }
        }
        let first = try? swinject.instance(of: Human.self)
        let second = try? swinject.instance(of: Human.self)
        expect(first) === second
    }
    it("does not reuse singleton instances for different tags") {
        let swinject = Swinject {
            bbind(Human.self, tagged: "john") & singleton { Human() }
            bbind(Human.self, tagged: "rick") & singleton { Human() }
        }
        let john = try? swinject.instance(of: Human.self, tagged: "john")
        let rick = try? swinject.instance(of: Human.self, tagged: "rick")
        expect(john) !== rick
    }
    it("injects the same instance from multiton binding when using the same argument") {
        let swinject = Swinject {
            bbind(Human.self) & provider { Human() }
            bbind(Pet.self) & multiton { Pet(name: $1, owner: try $0.instance()) }
        }
        let first = try? swinject.instance(of: Pet.self, arg: "mimi")
        let second = try? swinject.instance(of: Pet.self, arg: "mimi")
        expect(first) === second
    }
    it("injects a different instance from multiton binding when using a different argument") {
        let swinject = Swinject {
            bbind(Human.self) & provider { Human() }
            bbind(Pet.self) & multiton { Pet(name: $1, owner: try $0.instance()) }
        }
        let mimi = try? swinject.instance(of: Pet.self, arg: "mimi")
        let riff = try? swinject.instance(of: Pet.self, arg: "riff")
        expect(mimi) !== riff
    }
    it("can use up to 5 arguments in multiton binding") {
        let swinject = Swinject {
            bbind(Int.self) & multiton { (_, a1: Int) in a1 }
            bbind(Int.self) & multiton { (_, a1: Int, a2: Int) in a1 + a2 }
            bbind(Int.self) & multiton { (_, a1: Int, a2: Int, a3: Int) in a1 + a2 + a3 }
            bbind(Int.self) & multiton { (_, a1: Int, a2: Int, a3: Int, a4: Int) in a1 + a2 + a3 + a4 }
            bbind(Int.self) & multiton { (_, a1: Int, a2: Int, a3: Int, a4: Int, a5: Int) in a1 + a2 + a3 + a4 + a5 }
        }
        expect { try swinject.instance(of: Int.self, arg: 1) } == 1
        expect { try swinject.instance(of: Int.self, arg: 1, 2) } == 3
        expect { try swinject.instance(of: Int.self, arg: 1, 2, 3) } == 6
        expect { try swinject.instance(of: Int.self, arg: 1, 2, 3, 4) } == 10
        expect { try swinject.instance(of: Int.self, arg: 1, 2, 3, 4, 5) } == 15
    }
    describe("weak reference") {
        it("it releases instance if it is not used") {
            let swinject = Swinject {
                bbind(Human.self) & singleton(ref: weakRef) { Human() }
            }
            weak var first = try? swinject.instance() as Human
            expect(first).to(beNil())
        }
        it("injects the same instance while it is used") {
            let swinject = Swinject {
                bbind(Human.self) & singleton(ref: weakRef) { Human() }
            }
            let first = try? swinject.instance(of: Human.self)
            let second = try? swinject.instance(of: Human.self)
            expect(first) === second
        }
    }
    #endif
} }
