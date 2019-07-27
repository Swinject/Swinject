//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class ModulesSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can separate bindings into modules") {
        let intModule = Swinject.Module("Int") {
            bbind(Int.self) & 42
        }
        let doubleModule = Swinject.Module("Double") {
            bbind(Double.self) & provider { 25 + 17 }
        }
        let swinject = Swinject {
            include(intModule)
            include(doubleModule)
        }
        expect { try swinject.instance() as Int } == 42
        expect { try swinject.instance() as Double } == 42.0
    }
    it("can handle module hierarchies") {
        let intModule = Swinject.Module("Int") {
            bbind(Int.self) & 42
        }
        let numbersModule = Swinject.Module("Double") {
            include(intModule)
            bbind(Double.self) & provider { 25 + 17 }
        }
        let swinject = Swinject {
            include(numbersModule)
        }
        expect { try swinject.instance() as Int } == 42
        expect { try swinject.instance() as Double } == 42.0
    }
    it("does not allow modules with the same name") {
        let firstModule = Swinject.Module("name")
        let secondModule = Swinject.Module("name")
        expect {
            _ = Swinject {
                include(firstModule)
                include(secondModule)
            }
        }.to(throwAssertion())
    }
    it("fails if module is included multiple times") {
        let firstModule = Swinject.Module("first")
        let secondModule = Swinject.Module("second") {
            include(firstModule)
        }
        let thirdModule = Swinject.Module("third") {
            include(firstModule)
        }
        expect {
            _ = Swinject {
                include(secondModule)
                include(thirdModule)
            }
        }.to(throwAssertion())
    }
    #endif
} }
