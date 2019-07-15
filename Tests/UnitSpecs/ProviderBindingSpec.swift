//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ProviderBindingSpec: QuickSpec { override func spec() {
    it("returns instance made by provider method") {
        let binding = provider { 42 }
        expect { try binding.instance(injector: DummyInjector()) } == 42
    }
    it("does not call builder until instance is requested") {
        var called = false
        _ = provider { called = true }
        expect(called).to(beFalse())
    }
    it("calls builder with given provider") {
        var passedInjector: Injector?
        let injector = DummyInjector()
        let binding = provider { passedInjector = $0 }
        _ = try? binding.instance(injector: injector)
        expect(passedInjector) === injector
    }
    it("rethrows error from builder") {
        let binding = provider { throw SwinjectError() }
        expect { try binding.instance(injector: DummyInjector()) }.to(throwError())
    }
    it("does not reuse instance") {
        let binding = provider { Person() }
        let instance1 = try? binding.instance(injector: DummyInjector())
        let instance2 = try? binding.instance(injector: DummyInjector())
        expect(instance1) !== instance2
    }
} }
