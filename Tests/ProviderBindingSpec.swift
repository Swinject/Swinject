//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ProviderBindingSpec: QuickSpec { override func spec() {
    it("returns instance made by provider method") {
        let binding = provider { 42 }
        expect { try binding.instance(using: FakeInjector()) } == 42
    }
    it("does not call builder until instance is requested") {
        var called = false
        _ = provider { called = true }
        expect(called).to(beFalse())
    }
    it("calls builder with given provider") {
        var passedProvider: Injector?
        let fake = FakeInjector()
        let binding = provider { passedProvider = $0 }
        _ = try? binding.instance(using: fake)
        expect(passedProvider) === fake
    }
    it("rethrows error from builder") {
        let binding = provider { throw SwinjectError() }
        expect { try binding.instance(using: FakeInjector()) }.to(throwError())
    }
    it("does not reuse instance") {
        let binding = provider { Person() }
        let instance1 = try? binding.instance(using: FakeInjector())
        let instance2 = try? binding.instance(using: FakeInjector())
        expect(instance1) !== instance2
    }
}}
