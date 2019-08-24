//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
// swiftlint:disable force_try

class RetrievalSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    // TODO: Better support
    it("can retrieve bound types") {
        struct IntHolder: SwinjectAware {
            let swinject: Resolver
            lazy var int: Int = try! instance().from(swinject)
        }
        let swinject = Swinject {
            register().factory { IntHolder(swinject: $0) }
            register().constant(42)
        }
        var holder = try? instance().from(swinject) as IntHolder
        expect(holder?.int) == 42
    }
    #endif
} }
