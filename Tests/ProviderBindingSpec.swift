//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ProviderBindingSpec: QuickSpec { override func spec() {
    describe("value") {
        it("returns given value") {
            let binding = vvalue(42)
            expect { try binding.instance(using: FakeProvider()) } == 42
        }
    }
    describe("provider") {
        it("returns instance made by provider method") {
            let binding = provider { 42 }
            expect { try binding.instance(using: FakeProvider()) } == 42
        }
        it("does not call provider method until instance is requested") {
            var called = false
            _ = provider { called = true }
            expect(called).to(beFalse())
        }
        it("calls facrory method with given provider") {
            var passedProvider: Provider?
            let provider = FakeProvider()
            let binding = factory { passedProvider = $0 }
            _ = try? binding.instance(using: provider)
            expect(passedProvider) === provider
        }
        it("rethrows error from provider method") {
            let binding = provider { throw SwinjectError() }
            expect { try binding.instance(using: FakeProvider()) }.to(throwError())
        }
    }
    // TODO: Initializer
}}
