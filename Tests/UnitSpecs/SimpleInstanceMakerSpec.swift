//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SimpleInstanceMakerSpec: QuickSpec { override func spec() {
    describe("instance") {
        it("produces maker with correct type signature") {
            let maker = instance(42) as Any
            expect(maker is SimpleInstanceMaker<Int, Any, Void>).to(beTrue())
        }
        it("returns given instance") {
            let maker = instance(42)
            expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
        }
    }
    describe("provider") {
        // TODO: Can we reuse tests for with / without context?
        describe("without context") {
            it("produces maker with correct type signature") {
                let maker = provider { 42 } as Any
                expect(maker is SimpleInstanceMaker<Int, Any, Void>).to(beTrue())
            }
            it("returns instance made by provider method") {
                let maker = provider { 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = provider { called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given provider") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = provider { passedResolver = $0 }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("rethrows error from builder") {
                let maker = provider { throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = provider { Person() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
        describe("contexted") {
            it("returns instance made by provider method") {
                let maker = contexted(Any.self).provider { _, _ in 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = provider { called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given provider") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = contexted(Any.self).provider { r, _ in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Int?
                let maker = contexted(Int.self).provider { _, c in passedContext = c }
                _ = try? maker.makeInstance(context: 42, resolver: DummyResolver())
                expect(passedContext) == 42
            }
            it("rethrows error from builder") {
                let maker = contexted(Any.self).provider { _, _ in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = contexted(Any.self).provider { _, _ in Person() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
    }
    describe("factory") {
        describe("without context") {
            it("produces maker with correct type signature") {
                let maker = factory { (_, _: Void) in 42 } as Any
                expect(maker is SimpleInstanceMaker<Int, Any, Void>).to(beTrue())
            }
            it("returns instance made by builder method") {
                let maker = factory { (_, _: Void) in 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = factory { (_, _: Void) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given provider") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = factory { (r, _: Void) in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = factory { (_, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: 42, resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = factory { (_, _: Void) in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = factory { (_, _: Void) in Person() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = factory { (_, _: Int, _: Double) in 42 }
                    let arguments = (1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = factory { (_, _: Int, _: Double, _: String) in 42 }
                    let arguments = (1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = factory { (_, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = factory { (_, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
        describe("contexted") {
            it("returns instance made by builder method") {
                let maker = contexted(Any.self).factory { (_, _, _: Void) in 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = contexted(Any.self).factory { (_, _, _: Void) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given provider") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = contexted(Any.self).factory { (r, _, _: Void) in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Int?
                let maker = contexted(Int.self).factory { (_, c, _: Void) in passedContext = c }
                _ = try? maker.makeInstance(context: 42, resolver: DummyResolver())
                expect(passedContext) == 42
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = contexted(Any.self).factory { (_, _, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: 42, resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = contexted(Any.self).factory { (_, _, _: Void) in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = contexted(Any.self).factory { (_, _, _: Void) in Person() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = contexted(Any.self).factory { (_, _, _: Int, _: Double) in 42 }
                    let arguments = (1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = contexted(Any.self).factory { (_, _, _: Int, _: Double, _: String) in 42 }
                    let arguments = (1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = contexted(Any.self).factory { (_, _, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = contexted(Any.self).factory { (_, _, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
    }
} }
