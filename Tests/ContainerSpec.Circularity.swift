//
//  ContainerSpec.Circularity.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/29/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_Circularity: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }
        
        describe("Two objects") {
            it("resolves circular dependency on each property.") {
                let runInObjectScope: ObjectScope -> Void = { scope in
                    container.removeAll()
                    container.register(ParentType.self) { _ in Parent() }
                        .initCompleted { r, s in
                            let parent = s as! Parent
                            parent.child = r.resolve(ChildType.self)
                        }
                        .inObjectScope(scope)
                    container.register(ChildType.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentType.self)!
                        }
                        .inObjectScope(scope)
                    
                    let parent = container.resolve(ParentType.self) as! Parent
                    let child = parent.child as! Child
                    expect(child.parent as? Parent) === parent
                }
                
                runInObjectScope(.Graph)
                runInObjectScope(.Container)
                runInObjectScope(.Hierarchy)
            }
            it("resolves circular dependency on the initializer and property.") {
                let runInObjectScope: ObjectScope -> Void = { scope in
                    container.removeAll()
                    container.register(ParentType.self) { r in Parent(child: r.resolve(ChildType.self)!) }
                        .inObjectScope(scope)
                    container.register(ChildType.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentType.self)
                        }
                        .inObjectScope(scope)
                    
                    let parent = container.resolve(ParentType.self) as! Parent
                    let child = parent.child as! Child
                    expect(child.parent as? Parent) === parent
                }
                
                runInObjectScope(.Graph)
                runInObjectScope(.Container)
                runInObjectScope(.Hierarchy)
            }
            it("resolves circular dependency while intantiating each singleton object only once.") {
                let runInObjectScope: ObjectScope -> Void = { scope in
                    container.removeAll()
                    Parent.numberOfInstances = 0
                    Child.numberOfInstances = 0
                    container.register(ParentType.self) { r in Parent(child: r.resolve(ChildType.self)!) }
                        .inObjectScope(scope)
                    container.register(ChildType.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentType.self)
                        }
                        .inObjectScope(scope)
                    
                    container.resolve(ParentType.self)
                    container.resolve(ChildType.self)
                    expect(Parent.numberOfInstances) == 1
                    expect(Child.numberOfInstances) == 1
                }
                
                runInObjectScope(.Container)
                runInObjectScope(.Hierarchy)
            }

        }
        describe("More than two objects") {
            it("resolves circular dependency on properties.") {
                container.register(AType.self) { _ in ADependingOnB() }
                    .initCompleted {
                        let a = $1 as! ADependingOnB
                        a.b = $0.resolve(BType.self)
                    }
                container.register(BType.self) { _ in BDependingOnC() }
                    .initCompleted {
                        let b = $1 as! BDependingOnC
                        b.c = $0.resolve(CType.self)
                    }
                container.register(CType.self) { _ in CDependingOnAD() }
                    .initCompleted {
                        let c = $1 as! CDependingOnAD
                        c.a = $0.resolve(AType.self)
                        c.d = $0.resolve(DType.self)
                    }
                container.register(DType.self) { _ in DDependingOnBC() }
                    .initCompleted {
                        let d = $1 as! DDependingOnBC
                        d.b = $0.resolve(BType.self)
                        d.c = $0.resolve(CType.self)
                    }
                
                let a = container.resolve(AType.self) as! ADependingOnB
                let b = a.b as! BDependingOnC
                let c = b.c as! CDependingOnAD
                let d = c.d as! DDependingOnBC
                expect(c.a as? ADependingOnB) === a
                expect(d.b as? BDependingOnC) === b
                expect(d.c as? CDependingOnAD) === c
            }
            it("resolves circular dependency on initializers and properties.") {
                container.register(AType.self) { r in ADependingOnB(b: r.resolve(BType.self)!) }
                container.register(BType.self) { r in BDependingOnC(c: r.resolve(CType.self)!) }
                container.register(CType.self) { r in CDependingOnAD(d: r.resolve(DType.self)!) }
                    .initCompleted {
                        let c = $1 as! CDependingOnAD
                        c.a = $0.resolve(AType.self)
                    }
                container.register(DType.self) { _ in DDependingOnBC() }
                    .initCompleted {
                        let d = $1 as! DDependingOnBC
                        d.b = $0.resolve(BType.self)
                        d.c = $0.resolve(CType.self)
                    }
                
                let a = container.resolve(AType.self) as! ADependingOnB
                let b = a.b as! BDependingOnC
                let c = b.c as! CDependingOnAD
                let d = c.d as! DDependingOnBC
                expect(c.a as? ADependingOnB) === a
                expect(d.b as? BDependingOnC) === b
                expect(d.c as? CDependingOnAD) === c
            }
            it("resolves circular dependencies as soon as possible during the construction of the tree") {
                container.register(FType.self) { r in FDependindOnG(g: r.resolve(GType.self)!) }
                container.register(GType.self) { r in GDependingOnH() }
                    .initCompleted { r, g in
                        g.h = r.resolve(HType.self)
                }
                container.register(HType.self) { r in HDependingOnG(g: r.resolve(GType.self)!) }
                
                let f = container.resolve(FType.self)! as! FDependindOnG
                expect(f.gFooWasSuccessful) == true
            }
        }
    }
}
