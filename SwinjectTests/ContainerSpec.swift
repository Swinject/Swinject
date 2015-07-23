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
