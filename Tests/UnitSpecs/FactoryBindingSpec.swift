//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class FactoryBindingSpec: QuickSpec { override func spec() {
    it("returns instance made by builder method") {
        let binding = factory { (_, _: Void) in 42 }
        expect { try binding.instance(injector: DummyInjector()) } == 42
    }
    it("does not call builder until instance is requested") {
        var called = false
        _ = factory { (_, _: Void) in called = true }
        expect(called).to(beFalse())
    }
    it("calls builder with given provider") {
        var passedInjector: Injector?
        let injector = DummyInjector()
        let binding = factory { (_, _: Void) in passedInjector = injector }
        _ = try? binding.instance(injector: injector)
        expect(passedInjector) === injector
    }
    it("calls builder with given argument") {
        var passedArgument: Int?
        let binding = factory { (_, arg: Int) in passedArgument = arg }
        _ = try? binding.instance(arg: 42, injector: DummyInjector())
        expect(passedArgument) == 42
    }
    it("rethrows error from builder") {
        let binding = factory { (_, _: Void) in throw SwinjectError() }
        expect { try binding.instance(injector: DummyInjector()) }.to(throwError())
    }
    it("does not reuse instance") {
        let binding = factory { (_, _: Void) in Person() }
        let instance1 = try? binding.instance(injector: DummyInjector())
        let instance2 = try? binding.instance(injector: DummyInjector())
        expect(instance1) !== instance2
    }
    describe("multiple arguments") {
        it("works with 2 arguments") {
            let binding = factory { (_, _: Int, _: Double) in 42 }
            let arguments = (1, 1.0)
            expect { try binding.instance(arg: arguments, injector: DummyInjector()) } == 42
        }
        it("works with 3 arguments") {
            let binding = factory { (_, _: Int, _: Double, _: String) in 42 }
            let arguments = (1, 1.0, "")
            expect { try binding.instance(arg: arguments, injector: DummyInjector()) } == 42
        }
        it("works with 4 arguments") {
            let binding = factory { (_, _: Int, _: Double, _: String, _: Float) in 42 }
            let arguments = (1, 1.0, "", Float(1.0))
            expect { try binding.instance(arg: arguments, injector: DummyInjector()) } == 42
        }
        it("works with 5 arguments") {
            let binding = factory { (_, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
            let arguments = (1, 1.0, "", Float(1.0), 5)
            expect { try binding.instance(arg: arguments, injector: DummyInjector()) } == 42
        }
    }
} }
