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
    it("can declare that binding overrides previous binding for the same type") {
        let swinject = Swinject {
            bbind(Int.self) & 0
            bbind(Int.self, overrides: true) & 42
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("uses the last overriding binding for the injection") {
        let swinject = Swinject {
            bbind(Int.self) & 1
            bbind(Int.self, overrides: true) & 2
            bbind(Int.self, overrides: true) & 42
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("must declare overriding binding after the overriden one") {
        expect {
            _ = Swinject {
                bbind(Int.self, overrides: true) & 42
                bbind(Int.self) & 0
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow overriding binding if there is nothing to override") {
        expect {
            _ = Swinject {
                bbind(Int.self, overrides: true) & 42
            }
        }.ifDebugTo(throwAssertion())
    }
    it("does not allow overriding bindings in modules by default") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 0
        }
        let secondModule = Swinject.Module("second") {
            bbind(Int.self, overrides: true) & 42
        }
        expect {
            _ = Swinject {
                include(firstModule)
                include(secondModule)
            }
        }.ifDebugTo(throwAssertion())
    }
    it("can allow module to have overriding bindings when including it") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 0
        }
        let secondModule = Swinject.Module("second") {
            bbind(Int.self, overrides: true) & 42
        }
        let swinject = Swinject {
            include(firstModule)
            include(secondModule, allowToOverride: true)
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("allows overriding bindings in the entire included module tree") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 0
        }
        let secondModule = Swinject.Module("second") {
            bbind(Int.self, overrides: true) & 42
        }
        let thirdModule = Swinject.Module("third") {
            include(secondModule)
        }
        let swinject = Swinject {
            include(firstModule)
            include(thirdModule, allowToOverride: true)
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("can allow silent overrides in a module") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 0
        }
        let secondModule = Swinject.Module("second", allowsSilentOverride: true) {
            bbind(Int.self) & 42
        }
        let swinject = Swinject {
            include(firstModule)
            include(secondModule)
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    it("does not apply silent override transitively") {
        let firstModule = Swinject.Module("first") {
            bbind(Int.self) & 0
        }
        let secondModule = Swinject.Module("second") {
            bbind(Int.self) & 42
        }
        let thirdModule = Swinject.Module("third", allowsSilentOverride: true) {
            include(secondModule)
        }
        expect {
            _ = Swinject {
                include(firstModule)
                include(thirdModule)
            }
        }.ifDebugTo(throwAssertion())
    }
    it("can allow silent override on the Swinject declaration") {
        let swinject = Swinject(allowsSilentOverride: true) {
            bbind(Int.self) & 0
            bbind(Int.self) & 42
        }
        expect { try swinject.instance(of: Int.self) } == 42
    }
    #endif
} }
