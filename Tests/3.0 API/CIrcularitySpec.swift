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
            bbind(Foo.self) & provider { Foo(try $0.instance()) }
            bbind(Bar.self) & provider { Bar(try $0.instance()) }
        }
        expect { try swinject.instance(of: Foo.self) }.to(throwError())
    }
    it("does not produce false circularity detections") {
        let swinject = Swinject {
            bbind(Int.self) & 21
            bbind(Int.self, tagged: "computed") & provider { try $0.instance() + $0.instance() }
        }
        expect { try swinject.instance(of: Int.self, tagged: "computed") } == 42
    }
    it("can break circularity using Lazy wrapper") {
        class Foo { init(_: Bar) {} }
        class Bar { init(_: Lazy<Foo>) {} }
        let swinject = Swinject {
            bbind(Foo.self) & provider { Foo(try $0.instance()) }
            bbind(Bar.self) & provider { Bar(try $0.instance()) }
        }
        expect { try swinject.instance(of: Foo.self) }.notTo(throwError())
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
            bbind(Foo.self) & singleton(ref: weakRef) { Foo(try $0.instance()) }
            bbind(Bar.self) & provider { Bar(try $0.instance()) }
        }
        let foo = try? swinject.instance(of: Foo.self)
        expect { foo?.bar.foo } === foo
    }
    // FIXME: This segfaults on Xcode11 beta5
//    it("correctly injects dependencies if using Lazy Weak wrapper") {
//        class Foo {
//            let bar: Bar
//            init(_ bar: Bar) { self.bar = bar }
//        }
//        class Bar {
//            @Lazy @Weak var foo = nil as Foo?
//            init(_ foo: Lazy<Weak<Foo>>) { _foo = foo }
//        }
//        let swinject = Swinject {
//            bbind(Foo.self) & singleton(ref: weakRef) { Foo(try $0.instance()) }
//            bbind(Bar.self) & provider { Bar(try $0.instance()) }
//        }
//        let foo = try? swinject.instance(of: Foo.self)
//        expect { foo?.bar.foo } === foo
//    }
//    it("can avoid reference cycles if using Lazy Weak wrapper and weak singleton") {
//        class Foo {
//            let bar: Bar
//            init(_ bar: Bar) { self.bar = bar }
//        }
//        class Bar {
//            @Lazy @Weak var foo = nil as Foo?
//            init(_ foo: Lazy<Weak<Foo>>) { _foo = foo }
//        }
//        let swinject = Swinject {
//            bbind(Foo.self) & singleton(ref: weakRef) { Foo(try $0.instance()) }
//            bbind(Bar.self) & provider { Bar(try $0.instance()) }
//        }
//        var foo = try? swinject.instance(of: Foo.self)
//        let bar = foo?.bar
//
//        foo = nil
//
//        expect(bar?.foo).to(beNil())
//    }
    #endif
} }
