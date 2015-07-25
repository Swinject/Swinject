//
//  ContainerSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec: QuickSpec {
    override func spec() {
        describe("Basic resolution") {
            it("resolves a registreed instance.") {
                let container = Container()
                container.register(BarType.self) { _ in Bar() }
                
                let bar = container.resolve(BarType.self)
                expect(bar).notTo(beNil())
            }
            it("injects a resolved argument.") {
                let container = Container()
                container.register(BarType.self) { _ in Bar() }
                container.register(FooType.self) { c in Foo(bar: c.resolve(BarType.self)!) }
                    
                let foo = container.resolve(FooType.self) as? Foo
                expect(foo?.bar).notTo(beNil())
            }
            it("resolves multiple initializers with arguments passed.") {
                let container = Container()
                container.register(BarType.self) { _ in Bar() }
                container.register(BarType.self) { container, arg in Bar(arg1: arg) }
                container.register(BarType.self) { container, arg1, arg2 in Bar(arg1: arg1, arg2: arg2) }
                
                let bar0 = container.resolve(BarType.self) as! Bar
                let bar1 = container.resolve(BarType.self, arg1: "swift") as! Bar
                let bar2 = container.resolve(BarType.self, arg1: "swinject", arg2: true) as! Bar
                expect(bar0.arg1).to(beEmpty())
                expect(bar1.arg1) == "swift"
                expect(bar2.arg1) == "swinject"
                expect(bar2.arg2) == true
            }
            it("resolves named services.") {
                let container = Container()
                container.register(BarType.self, name: "regA") { _ in Bar(arg1: "a") }
                container.register(BarType.self, name: "regB") { _ in Bar(arg1: "b") }
                container.register(BarType.self) { _ in Bar(arg1: "no name") }
                
                let a = container.resolve(BarType.self, name: "regA") as! Bar
                let b = container.resolve(BarType.self, name: "regB") as! Bar
                let noname = container.resolve(BarType.self) as! Bar
                expect(a.arg1) == "a"
                expect(b.arg1) == "b"
                expect(noname.arg1) == "no name"
            }
        }
        describe("Container hierarchy") {
            it("resolves a service registered on the parent container.") {
                let parent = Container()
                parent.register(BarType.self) { _ in Bar() }
                let child = Container(parent: parent)
                
                let bar = child.resolve(BarType.self)
                expect(bar).notTo(beNil())
            }
            it("does not resolve a service registred on the child container.") {
                let parent = Container()
                let child = Container(parent: parent)
                child.register(BarType.self) { _ in Bar() }
                
                let bar = parent.resolve(BarType.self)
                expect(bar).to(beNil())
            }
        }
        describe("Scope") {
            context("in no scope") {
                it("does not have a shared object in a container.") {
                    let container = Container()
                    container.register(BarType.self) { _ in Bar() }
                    
                    let bar1 = container.resolve(BarType.self) as! Bar
                    let bar2 = container.resolve(BarType.self) as! Bar
                    expect(bar1) !== bar2
                }
            }
            context("in container scope") {
                it("shares an object in the own container.") {
                    let container = Container()
                    container.register(BarType.self) { _ in Bar() }
                        .inObjectScope(.Container)
                    
                    let bar1 = container.resolve(BarType.self) as! Bar
                    let bar2 = container.resolve(BarType.self) as! Bar
                    expect(bar1) === bar2
                }
                it("does not share an object from a parent container to its child.") {
                    let parent = Container()
                    parent.register(BarType.self) { _ in Bar() }
                        .inObjectScope(.Container)
                    parent.register(FooType.self) { _ in Foo() }
                        .inObjectScope(.Container)
                    let child = Container(parent: parent)
                    
                    // Case resolving on the parent first.
                    let bar1 = parent.resolve(BarType.self) as! Bar
                    let bar2 = child.resolve(BarType.self) as! Bar
                    expect(bar1) !== bar2
                    
                    // Case resolving on the child first.
                    let foo1 = child.resolve(FooType.self) as! Foo
                    let foo2 = parent.resolve(FooType.self) as! Foo
                    expect(foo1) !== foo2
                }
            }
            context("in hierarchy scope") {
                it("shares an object in the own container.") {
                    let container = Container()
                    container.register(BarType.self) { _ in Bar() }
                        .inObjectScope(.Hierarchy)
                    
                    let bar1 = container.resolve(BarType.self) as! Bar
                    let bar2 = container.resolve(BarType.self) as! Bar
                    expect(bar1) === bar2
                }
                it("shares an object from a parent container to its child.") {
                    let parent = Container()
                    parent.register(BarType.self) { _ in Bar() }
                        .inObjectScope(.Hierarchy)
                    parent.register(FooType.self) { _ in Foo() }
                        .inObjectScope(.Hierarchy)
                    let child = Container(parent: parent)
                    
                    // Case resolving on the parent first.
                    let bar1 = parent.resolve(BarType.self) as! Bar
                    let bar2 = child.resolve(BarType.self) as! Bar
                    expect(bar1) === bar2
                    
                    // Case resolving on the child first.
                    let foo1 = child.resolve(FooType.self) as! Foo
                    let foo2 = parent.resolve(FooType.self) as! Foo
                    expect(foo1) === foo2
                }
            }
        }
    }
}

internal protocol BarType { }
internal protocol FooType { }

internal class Bar : BarType {
    var arg1: String = ""
    var arg2: Bool?
    
    init() {
        self.arg1 = ""
    }
    
    init(arg1: String) {
        self.arg1 = arg1
    }
    
    init(arg1: String, arg2: Bool) {
        self.arg1 = arg1
        self.arg2 = arg2
    }
}

internal class Foo : FooType {
    var bar: BarType?
    
    init() {
    }
    
    init(bar: BarType) {
        self.bar = bar
    }
}
