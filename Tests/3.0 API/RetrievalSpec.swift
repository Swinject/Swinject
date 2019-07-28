//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
// swiftlint:disable force_try

class RetrievalSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can retrieve bound types") {
        struct IntHolder: SwinjectAware {
            let swinject: Resolver
            lazy var int: Int = try! instance()
        }
        let swinject = Swinject {
            bbind(IntHolder.self) & provider { IntHolder(swinject: $0) }
            bbind(Int.self) & 42
        }
        var holder = try? swinject.instance() as IntHolder
        expect(holder?.int) == 42
    }
    #endif
} }
