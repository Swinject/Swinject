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
            container.register(BarType.self) { Bar() }
            container.register(FooType.self) { Foo() }
            
            let bar = container.resolve(BarType.self)
            let foo = container.resolve(FooType.self)
            expect(bar).notTo(beNil())
            expect(foo).notTo(beNil())
        }
    }
}

private protocol BarType { }
private protocol FooType { }

private class Bar : BarType { }
private class Foo : FooType {
    var bar: BarType?
    
    init() {
    }
    
    init(bar: BarType) {
        self.bar = bar
    }
}
