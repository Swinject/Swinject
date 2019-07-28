//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import class Swinject.UnboundScope

class SwinjectApiSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    beforeEach {
        UnboundScope.root.close()
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
        expect { try swinject.on(Human()).instance() as Int } == 42
    }
    it("can translate contexts") {
        // FIXME: compiler segfaults if declaring these providers inside function builder
        let intProvider = contexted(String.self).provider { _, string in Int(string)! }
        let doubleProvider = contexted(Int.self).provider { _, int in Double(int) }
        let swinject = Swinject {
            bbind(Int.self) & intProvider
            bbind(Double.self) & doubleProvider
            registerContextTranslator(from: String.self) { Int($0)! }
        }
        let contexted = swinject.on("42")
        expect { try contexted.instance(of: Int.self) } == 42
        expect { try contexted.instance(of: Double.self) } == 42
    }
    it("can bind singleton") {
        let swinject = Swinject {
            bbind(Human.self) & singleton { Human() }
        }
        let first = try? swinject.instance() as Human
        let second = try? swinject.instance() as Human
        expect(first) === second
    }
    it("can bind weakly referenced singleton") {
        let swinject = Swinject {
            bbind(Human.self) & singleton(ref: weakRef) { Human() }
        }
        weak var first = try? swinject.instance() as Human
        expect(first).to(beNil())
    }
    it("can bind multitons") {
        let swinject = Swinject {
            bbind(Building.self) & multiton { Building(floors: $1) }
        }
        let house1 = try? swinject.instance(arg: 1) as Building
        let house2 = try? swinject.instance(arg: 1) as Building
        let skyscrapper = try? swinject.instance(arg: 100) as Building
        expect(house1) === house2
        expect(skyscrapper) !== house1
    }
    #endif
} }
