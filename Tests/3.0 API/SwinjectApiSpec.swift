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
