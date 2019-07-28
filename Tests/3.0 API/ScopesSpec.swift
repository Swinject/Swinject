//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class ScopesSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can bind scoped singleton") {
        let scope = UnboundScope()
        let swinject = Swinject {
            bbind(Human.self) & scoped(scope).singleton { Human() }
        }
        let first = try? swinject.instance() as Human
        let second = try? swinject.instance() as Human
        expect(first) === second
    }
    it("can close scopes") {
        let scope = UnboundScope()
        let swinject = Swinject {
            bbind(Human.self) & scoped(scope).singleton { Human() }
        }
        let first = try? swinject.instance() as Human
        scope.close()
        let second = try? swinject.instance() as Human
        expect(first) !== second
    }
    it("notifies instances when scope is closed") {
        let scope = UnboundScope()
        let swinject = Swinject {
            bbind(ClosableMock.self) & scoped(scope).singleton { ClosableMock() }
        }
        let closable = try? swinject.instance() as ClosableMock
        expect(closable?.closeCalled) == false
        scope.close()
        expect(closable?.closeCalled) == true
    }
    #endif
} }
