//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

// TODO: Reuse code between scoped / simple instance maker

class ScopedInstanceMakerSpec: QuickSpec { override func spec() {
    describe("explicit scope") {
        var scope = ScopeMock()
        var environment: BinderEnvironment<ScopeMock, ScopeMock.Context>!
        beforeEach {
            scope = ScopeMock()
            environment = scoped(scope)
        }
        describe("singleton") {
            it("has correct scope") {
                let maker = environment.singleton { 42 }
                expect(maker.scope) === scope
            }
            it("returns instance made by builder") {
                let maker = environment.singleton { 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = environment.singleton { called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = environment.singleton { passedResolver = $0 }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Any?
                let maker = environment.singleton { _, c in passedContext = c }
                _ = try? maker.makeInstance(context: "context", resolver: DummyResolver())
                expect(passedContext as? String) == "context"
            }
            it("rethrows error from builder") {
                let maker = environment.singleton { throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = environment.singleton { _, _ in Person() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
        describe("multiton") {
            it("has correct scope") {
                let maker = environment.multiton { (_, _, _: Void) in 42 }
                expect(maker.scope) === scope
            }
            it("returns instance made by builder method") {
                let maker = environment.multiton { (_, _, _: Void) in 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = environment.multiton { (_, _, _: Void) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = environment.multiton { (r, _, _: Void) in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Any?
                let maker = environment.multiton { (_, c, _: Void) in passedContext = c }
                _ = try? maker.makeInstance(context: "context", resolver: DummyResolver())
                expect(passedContext as? String) == "context"
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = environment.multiton { (_, _, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: 42, resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = environment.multiton { (_, _, _: Void) in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = environment.multiton { (_, _, _: Void) in Person() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double) in 42 }
                    let arguments = (1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double, _: String) in 42 }
                    let arguments = (1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = (1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
    }
} }
