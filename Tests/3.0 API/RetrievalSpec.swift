//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class RetrievalSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can retrieve bound types") {
        class NumberHolder: SwinjectAware {
            @Injected var int: Int

            @Injected(instance(tagged: "tag", arg: 42))
            var double: Double

            let swinject: Resolver
            init(swinject: Resolver) { self.swinject = swinject }
        }
        let swinject = Swinject {
            register().factory { NumberHolder(swinject: $0) }
            register().constant(42)
            register().factory(tag: "tag") { Double($1 as Int) }
        }
        let holder = try? instance(of: NumberHolder.self).from(swinject)
        expect(holder?.int) == 42
        expect(holder?.double) == 42
    }
    #endif
} }
