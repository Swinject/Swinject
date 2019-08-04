//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class CircularitySpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("does not allow circular dependencies") {
        class Foo { init(_: Bar) {} }
        class Bar { init(_: Foo) {} }
        let swinject = Swinject {
            bbind(Foo.self) & provider { Foo(try $0.instance()) }
            bbind(Bar.self) & provider { Bar(try $0.instance()) }
        }
        expect { try swinject.instance(of: Foo.self) }.to(throwError())
    }
    #endif
} }
