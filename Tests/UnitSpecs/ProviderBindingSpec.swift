//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ProviderBindingSpec: QuickSpec { override func spec() {
    it("returns instance made by provider method") {
        let binding = provider { 42 }
        expect { try binding.instance(resolver: DummyResolver()) } == 42
    }
    it("does not call builder until instance is requested") {
        var called = false
        _ = provider { called = true }
        expect(called).to(beFalse())
    }
    it("calls builder with given provider") {
        var passedResolver: Resolver?
        let resolver = DummyResolver()
        let binding = provider { passedResolver = $0 }
        _ = try? binding.instance(resolver: resolver)
        expect(passedResolver) === resolver
    }
    it("rethrows error from builder") {
        let binding = provider { throw SwinjectError() }
        expect { try binding.instance(resolver: DummyResolver()) }.to(throwError())
    }
    it("does not reuse instance") {
        let binding = provider { Person() }
        let instance1 = try? binding.instance(resolver: DummyResolver())
        let instance2 = try? binding.instance(resolver: DummyResolver())
        expect(instance1) !== instance2
    }
} }
