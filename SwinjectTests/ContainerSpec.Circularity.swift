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
                    container.register(ParentType.self) { _ in Mother() }
                        .initCompleted { r, s in
                            let mother = s as! Mother
                            mother.child = r.resolve(ChildType.self)
                        }
                        .inObjectScope(scope)
                    container.register(ChildType.self) { _ in Daughter() }
                        .initCompleted { r, s in
                            let daughter = s as! Daughter
                            daughter.parent = r.resolve(ParentType.self)!
                        }
                        .inObjectScope(scope)
                    
                    let mother = container.resolve(ParentType.self) as! Mother
                    let daughter = mother.child as! Daughter
                    expect(daughter.parent as? Mother) === mother
                }
                
                runInObjectScope(.Graph)
                runInObjectScope(.Container)
                runInObjectScope(.Hierarchy)
            }
            it("resolves circular dependency on the initializer and property.") {
                let runInObjectScope: ObjectScope -> Void = { scope in
                    container.removeAll()
                    container.register(ParentType.self) { r in Mother(child: r.resolve(ChildType.self)!) }
                        .inObjectScope(scope)
                    container.register(ChildType.self) { _ in Daughter() }
                        .initCompleted { r, s in
                            let daughter = s as! Daughter
                            daughter.parent = r.resolve(ParentType.self)
                        }
                        .inObjectScope(scope)
                    
                    let mother = container.resolve(ParentType.self) as! Mother
                    let daughter = mother.child as! Daughter
                    expect(daughter.parent as? Mother) === mother
                }
                
                runInObjectScope(.Graph)
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
        }
        describe("Infinite recursive call") {
            it("raises an exception to inform the problem to programmers.") {
                container.register(ParentType.self) { r in Mother(child: r.resolve(ChildType.self)!) }
                    .inObjectScope(.Graph)
                container.register(ChildType.self) { r in
                    let daughter = Daughter()
                    daughter.parent = r.resolve(ParentType.self)
                    return daughter
                }.inObjectScope(.Graph)
                
                expect(container.resolve(ParentType.self)).to(raiseException())
            }
        }
    }
}
