//
//  PropertyWrappersSpec.swift
//  Swinject
//
//  Created by Jakub Vano on 04/07/2019.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import Quick
import Nimble
@testable import Swinject

class PropertyWrappersSpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
            container.register(Bar.self) { _ in Bar() }
            container.register(Foo.self) { _ in Foo() }
        }
        it("shares instance during graph resolution") {
            let foo = container.resolve(Foo.self)!
            expect(foo.bar1) === foo.bar2
        }
        it("fails if manually creating instance") {
            expect { _ = Foo() }.to(throwAssertion())
        }
        describe("named service") {
            beforeEach {
                container.register(Bar.self, name: "1") { _ in Bar("1") }
                container.register(Bar.self, name: "2") { _ in Bar("2") }
                container.register(NameFoo.self) { _ in NameFoo() }
            }
            it("resolves properties with given name") {
                let foo = container.resolve(NameFoo.self)!
                expect(foo.bar1.name) == "1"
                expect(foo.bar2.name) == "2"
            }
        }
        describe("arguments") {
            beforeEach {
                container.register(Bar.self) { _, arg in Bar(arg) }
                container.register(Bar.self) { _, arg1, arg2 in Bar(arg1 + arg2) }
                container.register(ArgumentFoo.self) { _ in ArgumentFoo() }
            }
            it("resolves properties with given arguments") {
                let foo = container.resolve(ArgumentFoo.self)!
                expect(foo.bar1.name) == "1"
                expect(foo.bar2.name) == "12"
            }
        }
        describe("instance wrappers") {
            beforeEach {
                container.register(LazyFoo.self) { _ in LazyFoo() }
                container.register(ProviderFoo.self) { _ in ProviderFoo() }
            }
            it("resolves lazy property") {
                expect { _ = container.resolve(LazyFoo.self) }.notTo(throwAssertion())
            }
            it("shares lazy instance in graph scope") {
                let foo = container.resolve(LazyFoo.self)!
                expect(foo.bar1.instance) === foo.bar2
            }
            it("does not share provider instance in graph scope") {
                let foo = container.resolve(ProviderFoo.self)!
                expect(foo.bar1.instance) !== foo.bar2
            }
        }
    }
}

class Bar {
    let name: String
    init(_ name: String = "") { self.name = name }
}

class Foo {
    @Injected var bar1: Bar
    @Injected var bar2: Bar
}

class NameFoo {
    @Injected(name: "1") var bar1: Bar
    @Injected(name: "2") var bar2: Bar
}

class ArgumentFoo {
    @Injected(argument: "1") var bar1: Bar
    @Injected(arguments: "1", "2") var bar2: Bar
}

class LazyFoo {
    @Injected var bar1: Lazy<Bar>
    @Injected var bar2: Bar
}

class ProviderFoo {
    @Injected var bar1: Provider<Bar>
    @Injected var bar2: Bar
}
