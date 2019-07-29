//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class OverrideSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("does not allow multiple bindings for the same type") {
        expect {
            _ = Swinject {
                bbind(Int.self) & 42
                bbind(Int.self) & provider { 25 + 17 }
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow bindings for type and it's optional") {
        expect {
            _ = Swinject {
                bbind(Int?.self) & 42
                bbind(Int.self) & provider { 25 + 17 }
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow multiple bindings for the same type in a module hierarchy") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 42
        }
        expect {
            _ = Swinject {
                include(firstModule)
                bbind(Int.self) & provider { 25 + 17 }
            }
        }.ifDebugTo(throwAssertion())
    }
    #endif
} }
