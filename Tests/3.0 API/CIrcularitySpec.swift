//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class CircularitySpec: QuickSpec { override func spec() { #if swift(>=5.1)
    beforeEach {
        UnboundScope.root.close()
    }
    it("does not allow circular dependencies") {
        class Foo { init(_: Bar) {} }
        class Bar { init(_: Foo) {} }
        let swinject = Swinject {
            register().factory { Foo(try instance().from($0)) }
            register().factory { Bar(try instance().from($0)) }
        }
        expect { try instance(of: Foo.self).from(swinject) }.to(throwError())
    }
    it("does not produce false circularity detections") {
        let swinject = Swinject {
            register().constant(21)
            register().factory(for: Int.self, tag: "computed") { try instance().from($0) + instance().from($0) }
        }
        expect { try instance(of: Int.self, tagged: "computed").from(swinject) } == 42
    }
    it("can break circularity using Lazy wrapper") {
        class Foo { init(_: Bar) {} }
        class Bar { init(_: Lazy<Foo>) {} }
        let swinject = Swinject {
            register().factory { Foo(try instance().from($0)) }
            register().factory { Bar(try instance().from($0)) }
        }
        expect { try instance(of: Foo.self).from(swinject) }.notTo(throwError())
    }
    it("correctly injects dependencies if root is weak singleton") {
        class Foo {
            let bar: Bar
            init(_ bar: Bar) { self.bar = bar }
        }
        class Bar {
            @Lazy var foo: Foo
            init(_ foo: Lazy<Foo>) { _foo = foo }
        }
        let swinject = Swinject {
            register().factory { Bar(try instance().from($0)) }
            registerSingle()
                .factory { Foo(try instance().from($0)) }
                .withProperties { $0.reference = weakRef }
        }
        let foo = try? instance(of: Foo.self).from(swinject)
        expect { foo?.bar.foo } === foo
    }
    it("correctly injects dependencies if using Lazy Weak wrapper") {
        class Foo {
            let bar: Bar
            init(_ bar: Bar) { self.bar = bar }
        }
        class Bar {
            @Lazy @Weak var foo = nil as Foo?
            init(_ foo: Lazy<Weak<Foo>>) { _foo = foo }
        }
        let swinject = Swinject {
            register().factory { Bar(try instance().from($0)) }
            registerSingle()
                .factory { Foo(try instance().from($0)) }
                .withProperties { $0.reference = weakRef }
        }
        let foo = try? instance(of: Foo.self).from(swinject)
        expect { foo?.bar.foo } === foo
    }
    it("can avoid reference cycles if using Lazy Weak wrapper and weak singleton") {
        class Foo {
            let bar: Bar
            init(_ bar: Bar) { self.bar = bar }
        }
        class Bar {
            @Lazy @Weak var foo = nil as Foo?
            init(_ foo: Lazy<Weak<Foo>>) { _foo = foo }
        }
        let swinject = Swinject {
            register().factory { Bar(try instance().from($0)) }
            registerSingle()
                .factory { Foo(try instance().from($0)) }
                .withProperties { $0.reference = weakRef }
        }
        var foo = try? instance(of: Foo.self).from(swinject)
        let bar = foo?.bar

        foo = nil

        expect(bar?.foo).to(beNil())
    }
    #endif
} }
