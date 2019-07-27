//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

// TODO: Reuse code
class BinderEnvironmentSpec: QuickSpec { override func spec() {
    describe("implicit") {
        describe("instance") {
            it("produces maker with correct type signature") {
                let maker = instance(42)
                expect(maker.actual is SimpleBinding.Builder<Int, Any, Void>).to(beTrue())
            }
            it("returns given instance") {
                let maker = instance(42)
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
        }
        describe("provider") {
            it("produces maker with correct type signature") {
                let maker = provider { 42 }
                expect(maker.actual is SimpleBinding.Builder<Int, Any, Void>).to(beTrue())
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
            it("calls builder with given resolver") {
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
                let maker = provider { Human() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
        describe("factory") {
            it("produces maker with correct type signature") {
                let maker = factory { (_, _: Void) in 42 }
                expect(maker.actual is SimpleBinding.Builder<Int, Any, Void>).to(beTrue())
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
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = factory { (r, _: Void) in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = factory { (_, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: box(42), resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = factory { (_, _: Void) in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = factory { (_, _: Void) in Human() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = factory { (_, _: Int, _: Double) in 42 }
                    let arguments = box(1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = factory { (_, _: Int, _: Double, _: String) in 42 }
                    let arguments = box(1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = factory { (_, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = factory { (_, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
        describe("singleton") {
            it("has correct scope") {
                let maker = singleton { 0 }.actual as? ScopedBinding.Builder<Int, UnboundScope, Void>
                expect(maker?.scope) === UnboundScope.root
            }
            it("has correct reference maker") {
                let makeRef: ReferenceMaker<Int> = { _ in noRef(42) }
                let maker = singleton(ref: makeRef) { 0 }.actual as? ScopedBinding.Builder<Int, UnboundScope, Void>
                expect(maker?.makeRef(0).currentValue as? Int) == 42
            }
            it("returns instance made by builder") {
                let maker = singleton { 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = singleton { called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = singleton { passedResolver = $0 }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("rethrows error from builder") {
                let maker = singleton { throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = singleton { Human() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
        describe("multiton") {
            it("has correct scope") {
                let maker = multiton { (_, _: String) in 42 }
                let actualMaker = maker.actual as? ScopedBinding.Builder<Int, UnboundScope, MatchableBox1<String>>
                expect(actualMaker?.scope) === UnboundScope.root
            }
            it("has correct reference maker") {
                let makeRef: ReferenceMaker<Int> = { _ in noRef(42) }
                let maker = multiton(ref: makeRef) { (_, _: String) in 42 }
                let actualMaker = maker.actual as? ScopedBinding.Builder<Int, UnboundScope, MatchableBox1<String>>
                expect(actualMaker?.makeRef(0).currentValue as? Int) == 42
            }
            it("returns instance made by builder method") {
                let maker = multiton { (_, _: String) in 42 }
                expect { try maker.makeInstance(arg: box(""), resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = multiton { (_, _: String) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = multiton { (r, _: String) in passedResolver = r }
                _ = try? maker.makeInstance(arg: box(""), resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = multiton { (_, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: box(42), resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = multiton { (_, _: String) in throw SwinjectError() }
                expect { try maker.makeInstance(arg: box(""), resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = multiton { (_, _: String) in Human() }
                let instance1 = try? maker.makeInstance(arg: box(""), resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(arg: box(""), resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = multiton { (_, _: Int, _: Double) in 42 }
                    let arguments = box(1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = multiton { (_, _: Int, _: Double, _: String) in 42 }
                    let arguments = box(1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = multiton { (_, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = multiton { (_, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
    }
    describe("contexted") {
        var environment: BinderEnvironment<Void, Any>!
        beforeEach {
            environment = contexted(Any.self)
        }
        describe("provider") {
            it("returns instance made by provider method") {
                let maker = environment.provider { _, _ in 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = provider { called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = environment.provider { r, _ in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Any?
                let maker = environment.provider { _, c in passedContext = c }
                _ = try? maker.makeInstance(context: 42, resolver: DummyResolver())
                expect(passedContext as? Int) == 42
            }
            it("rethrows error from builder") {
                let maker = environment.provider { _, _ in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = environment.provider { _, _ in Human() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
        describe("factory") {
            it("returns instance made by builder method") {
                let maker = environment.factory { (_, _, _: Void) in 42 }
                expect { try maker.makeInstance(resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = environment.factory { (_, _, _: Void) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = environment.factory { (r, _, _: Void) in passedResolver = r }
                _ = try? maker.makeInstance(resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Any?
                let maker = environment.factory { (_, c, _: Void) in passedContext = c }
                _ = try? maker.makeInstance(context: 42, resolver: DummyResolver())
                expect(passedContext as? Int) == 42
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = environment.factory { (_, _, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: box(42), resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = environment.factory { (_, _, _: Void) in throw SwinjectError() }
                expect { try maker.makeInstance(resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = environment.factory { (_, _, _: Void) in Human() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = environment.factory { (_, _, _: Int, _: Double) in 42 }
                    let arguments = box(1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = environment.factory { (_, _, _: Int, _: Double, _: String) in 42 }
                    let arguments = box(1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = environment.factory { (_, _, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = environment.factory { (_, _, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
    }
    describe("scoped") {
        var scope = AnyScopeMock()
        var environment: BinderEnvironment<AnyScopeMock, AnyScopeMock.Context>!
        beforeEach {
            scope = AnyScopeMock()
            environment = scoped(scope)
        }
        describe("singleton") {
            it("has correct scope") {
                let maker = environment.singleton { 42 }
                let actualMaker = maker.actual as? ScopedBinding.Builder<Int, AnyScopeMock, Void>
                expect(actualMaker?.scope) === scope
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
                let maker = environment.singleton { _, _ in Human() }
                let instance1 = try? maker.makeInstance(resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(resolver: DummyResolver())
                expect(instance1) !== instance2
            }
        }
        describe("multiton") {
            it("has correct scope") {
                let maker = environment.multiton { (_, _, _: String) in 42 }
                let actualMaker = maker.actual as? ScopedBinding.Builder<Int, AnyScopeMock, MatchableBox1<String>>
                expect(actualMaker?.scope) === scope
            }
            it("returns instance made by builder method") {
                let maker = environment.multiton { (_, _, _: String) in 42 }
                expect { try maker.makeInstance(arg: box(""), resolver: DummyResolver()) } == 42
            }
            it("does not call builder until instance is requested") {
                var called = false
                _ = environment.multiton { (_, _, _: String) in called = true }
                expect(called).to(beFalse())
            }
            it("calls builder with given resolver") {
                var passedResolver: Resolver?
                let resolver = DummyResolver()
                let maker = environment.multiton { (r, _, _: String) in passedResolver = r }
                _ = try? maker.makeInstance(arg: box(""), resolver: resolver)
                expect(passedResolver) === resolver
            }
            it("calls builder with given context") {
                var passedContext: Any?
                let maker = environment.multiton { (_, c, _: String) in passedContext = c }
                _ = try? maker.makeInstance(arg: box(""), context: "context", resolver: DummyResolver())
                expect(passedContext as? String) == "context"
            }
            it("calls builder with given argument") {
                var passedArgument: Int?
                let maker = environment.multiton { (_, _, arg: Int) in passedArgument = arg }
                _ = try? maker.makeInstance(arg: box(42), resolver: DummyResolver())
                expect(passedArgument) == 42
            }
            it("rethrows error from builder") {
                let maker = environment.multiton { (_, _, _: String) in throw SwinjectError() }
                expect { try maker.makeInstance(arg: box(""), resolver: DummyResolver()) }.to(throwError())
            }
            it("does not reuse instance") {
                let maker = environment.multiton { (_, _, _: String) in Human() }
                let instance1 = try? maker.makeInstance(arg: box(""), resolver: DummyResolver())
                let instance2 = try? maker.makeInstance(arg: box(""), resolver: DummyResolver())
                expect(instance1) !== instance2
            }
            describe("multiple arguments") {
                it("works with 2 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double) in 42 }
                    let arguments = box(1, 1.0)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 3 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double, _: String) in 42 }
                    let arguments = box(1, 1.0, "")
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 4 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double, _: String, _: Float) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0))
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
                it("works with 5 arguments") {
                    let maker = environment.multiton { (_, _, _: Int, _: Double, _: String, _: Float, _: Int) in 42 }
                    let arguments = box(1, 1.0, "", Float(1.0), 5)
                    expect { try maker.makeInstance(arg: arguments, resolver: DummyResolver()) } == 42
                }
            }
        }
    }
} }

private extension SomeBindingMaker {
    var actual: AnyInstanceMaker { anyActual as! AnyInstanceMaker }

    func makeInstance(resolver: Resolver) throws -> BoundType {
        try actual.makeInstance(arg: (), context: (), resolver: resolver) as! BoundType
    }

    func makeInstance(context: Any, resolver: Resolver) throws -> BoundType {
        try actual.makeInstance(arg: (), context: context, resolver: resolver) as! BoundType
    }

    func makeInstance(arg: Any, resolver: Resolver) throws -> BoundType {
        try actual.makeInstance(arg: arg, context: (), resolver: resolver) as! BoundType
    }

    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> BoundType {
        try actual.makeInstance(arg: arg, context: context, resolver: resolver) as! BoundType
    }
}
