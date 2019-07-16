//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class BindingBuilderSpec: QuickSpec { override func spec() {
    describe("instance") {
        it("returns given instance") {
            let binding = instance(42)
            expect { try binding.instance(resolver: DummyResolver()) } == 42
        }
    }
    describe("provider") {
        // TODO: Can we reuse tests for with / without context?
        describe("without context") {
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
        }
        describe("contexted") {
            it("returns instance made by provider method") {
                let binding = contexted(Void.self).provider { _, _ in 42 }
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
                let binding = contexted(Void.self).provider { r, _ in passedResolver = r }
                _ = try? binding.instance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Int?
                let binding = contexted(Int.self).provider { _, c in passedContext = c }
                _ = try? binding.instance(context: 42, resolver: DummyResolver())
                expect(passedContext) == 42
            }
            it("rethrows error from builder") {
                let binding = contexted(Void.self).provider { _, _ in throw SwinjectError() }
                expect { try binding.instance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let binding = contexted(Void.self).provider { _, _ in Person() }
                let instance1 = try? binding.instance(resolver: DummyResolver())
                let instance2 = try? binding.instance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
    }
    describe("factory") {
        describe("without context") {
            it("returns instance made by builder method") {
                let binding = factory { (_, _: Void) in 42 }
                expect { try binding.instance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = factory { (_, _: Void) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given provider") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let binding = factory { (r, _: Void) in passedResolver = r }
                _ = try? binding.instance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let binding = factory { (_, arg: Int) in passedArgument = arg }
                _ = try? binding.instance(arg: 42, resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let binding = factory { (_, _: Void) in throw SwinjectError() }
                expect { try binding.instance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let binding = factory { (_, _: Void) in Person() }
                let instance1 = try? binding.instance(resolver: DummyResolver())
                let instance2 = try? binding.instance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let binding = factory { (_, _: Int, _: Double) in 42 }
                    let arguments = (1, 1.0)
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let binding = factory { (_, _: Int, _: Double, _: String) in 42 }
                    let arguments = (1, 1.0, "")
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let binding = factory { (_, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0))
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let binding = factory { (_, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0), 5)
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
        describe("contexted") {
            it("returns instance made by builder method") {
                let binding = contexted(Void.self).factory { (_, _, _: Void) in 42 }
                expect { try binding.instance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = contexted(Void.self).factory { (_, _, _: Void) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given provider") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let binding = contexted(Void.self).factory { (r, _, _: Void) in passedResolver = r }
                _ = try? binding.instance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Int?
                let binding = contexted(Int.self).factory { (_, c, _: Void) in passedContext = c }
                _ = try? binding.instance(context: 42, resolver: DummyResolver())
                expect(passedContext) == 42
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let binding = contexted(Void.self).factory { (_, _, arg: Int) in passedArgument = arg }
                _ = try? binding.instance(arg: 42, resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let binding = contexted(Void.self).factory { (_, _, _: Void) in throw SwinjectError() }
                expect { try binding.instance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let binding = contexted(Void.self).factory { (_, _, _: Void) in Person() }
                let instance1 = try? binding.instance(resolver: DummyResolver())
                let instance2 = try? binding.instance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let binding = contexted(Void.self).factory { (_, _, _: Int, _: Double) in 42 }
                    let arguments = (1, 1.0)
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let binding = contexted(Void.self).factory { (_, _, _: Int, _: Double, _: String) in 42 }
                    let arguments = (1, 1.0, "")
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let binding = contexted(Void.self).factory { (_, _, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0))
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let binding = contexted(Void.self).factory { (_, _, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0), 5)
                    expect { try binding.instance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
    }
} }
