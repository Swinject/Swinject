//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject3

class TypeProviderSpec: QuickSpec { override func spec() {
    describe("value") {
        it("returns given value") {
            let it = Swinject3.value(42)
            expect { try it.instance(using: FakeProvider()) } == 42
        }
    }
    describe("factory") {
        it("returns instance made by factory method") {
            let it = Swinject3.factory { 42 }
            expect { try it.instance(using: FakeProvider()) } == 42
        }
        it("does not call factory method until instance is requested") {
            var called = false
            _ = Swinject3.factory { called = true }
            expect(called).to(beFalse())
        }
        it("calls facrory method with given provider") {
            var passedProvider: Provider?
            let provider = FakeProvider()
            let it = Swinject3.factory { passedProvider = $0 }
            _ = try? it.instance(using: provider)
            expect(passedProvider) === provider
        }
        it("rethrows error from factory method") {
            let it = Swinject3.factory { throw SwinjectError() }
            expect { try it.instance(using: FakeProvider()) }.to(throwError())
        }
    }
    // TODO: Initializer
}}
