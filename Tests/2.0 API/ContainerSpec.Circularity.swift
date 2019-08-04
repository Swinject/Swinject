//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ContainerSpec_Circularity: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("Two objects") {
            it("resolves circular dependency on each property.") {
                let runInObjectScope: (ObjectScope) -> Void = { scope in
                    container.removeAll()
                    container.register(ParentProtocol.self) { _ in Parent() }
                        .initCompleted { r, s in
                            let parent = s as! Parent
                            parent.child = r.resolve(ChildProtocol.self)
                        }
                        .inObjectScope(scope)
                    container.register(ChildProtocol.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentProtocol.self)!
                        }
                        .inObjectScope(scope)

                    let parent = container.resolve(ParentProtocol.self) as! Parent
                    let child = parent.child as! Child
                    expect(child.parent as? Parent === parent).to(beTrue()) // Workaround for crash in Nimble
                }

                runInObjectScope(.graph)
                runInObjectScope(.container)
            }
            it("resolves circular dependency on the initializer and property.") {
                let runInObjectScope: (ObjectScope) -> Void = { scope in
                    container.removeAll()
                    container.register(ParentProtocol.self) { r in Parent(child: r.resolve(ChildProtocol.self)!) }
                        .inObjectScope(scope)
                    container.register(ChildProtocol.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentProtocol.self)
                        }
                        .inObjectScope(scope)

                    let parent = container.resolve(ParentProtocol.self) as! Parent
                    let child = parent.child as! Child
                    expect(child.parent as? Parent === parent).to(beTrue()) // Workaround for crash in Nimble
                }

                runInObjectScope(.graph)
                runInObjectScope(.container)
            }
        }
        describe("More than two objects") {
            it("resolves circular dependency on properties.") {
                container.register(A.self) { _ in ADependingOnB() }
                    .initCompleted {
                        let a = $1 as! ADependingOnB
                        a.b = $0.resolve(B.self)
                    }
                container.register(B.self) { _ in BDependingOnC() }
                    .initCompleted {
                        let b = $1 as! BDependingOnC
                        b.c = $0.resolve(C.self)
                    }
                container.register(C.self) { _ in CDependingOnAD() }
                    .initCompleted {
                        let c = $1 as! CDependingOnAD
                        c.a = $0.resolve(A.self)
                        c.d = $0.resolve(D.self)
                    }
                container.register(D.self) { _ in DDependingOnBC() }
                    .initCompleted {
                        let d = $1 as! DDependingOnBC
                        d.b = $0.resolve(B.self)
                        d.c = $0.resolve(C.self)
                    }

                let a = container.resolve(A.self) as! ADependingOnB
                let b = a.b as! BDependingOnC
                let c = b.c as! CDependingOnAD
                let d = c.d as! DDependingOnBC
                expect(c.a as? ADependingOnB === a).to(beTrue()) // Workaround for crash in Nimble
                expect(d.b as? BDependingOnC === b).to(beTrue()) // Workaround for crash in Nimble
                expect(d.c as? CDependingOnAD === c).to(beTrue()) // Workaround for crash in Nimble
            }
            it("resolves circular dependency on initializers and properties.") {
                container.register(A.self) { r in ADependingOnB(b: r.resolve(B.self)!) }
                container.register(B.self) { r in BDependingOnC(c: r.resolve(C.self)!) }
                container.register(C.self) { r in CDependingOnAD(d: r.resolve(D.self)!) }
                    .initCompleted {
                        let c = $1 as! CDependingOnAD
                        c.a = $0.resolve(A.self)
                    }
                container.register(D.self) { _ in DDependingOnBC() }
                    .initCompleted {
                        let d = $1 as! DDependingOnBC
                        d.b = $0.resolve(B.self)
                        d.c = $0.resolve(C.self)
                    }

                let a = container.resolve(A.self) as! ADependingOnB
                let b = a.b as! BDependingOnC
                let c = b.c as! CDependingOnAD
                let d = c.d as! DDependingOnBC
                expect(c.a as? ADependingOnB === a).to(beTrue()) // Workaround for crash in Nimble
                expect(d.b as? BDependingOnC === b).to(beTrue()) // Workaround for crash in Nimble
                expect(d.c as? CDependingOnAD === c).to(beTrue()) // Workaround for crash in Nimble
            }
        }
        describe("Graph root is in weak object scope") {
            it("does not deallocate during graph resolution") {
                container.register(B.self) { r in BDependingOnC(c: r.resolve(C.self)!) }
                    .inObjectScope(.weak)
                container.register(C.self) { _ in CDependingOnWeakB() }
                    .initCompleted { r, c in (c as! CDependingOnWeakB).b = r.resolve(B.self) }

                let b = container.resolve(B.self) as? BDependingOnC
                let c = b?.c as? CDependingOnWeakB

                expect(c?.b).notTo(beNil())
            }
        }
    }
}
