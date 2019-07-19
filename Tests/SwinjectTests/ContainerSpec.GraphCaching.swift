//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ContainerSpec_GraphCaching: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        it("has a method for restoring a graph") {
            container.restoreObjectGraph(GraphIdentifier())
        }

        describe("current object graph") {
            it("is not nil during graph resolution") {
                var identifier: GraphIdentifier?
                container.register(Dog.self) {
                    identifier = ($0 as? Container)?.currentObjectGraph
                    return Dog()
                }

                _ = container.resolve(Dog.self)

                expect(identifier).notTo(beNil())
            }
            it("is different for separate graph resolutions") {
                var identifiers = [GraphIdentifier?]()
                container.register(Dog.self) {
                    identifiers.append(($0 as? Container)?.currentObjectGraph)
                    return Dog()
                }

                _ = container.resolve(Dog.self)
                _ = container.resolve(Dog.self)

                expect(identifiers).to(haveCount(2))
                expect(identifiers[0]) != identifiers[1]
            }
            it("is the same during graph resolution") {
                var identifiers = [GraphIdentifier?]()
                container.register(Dog.self) {
                    identifiers.append(($0 as? Container)?.currentObjectGraph)
                    _ = $0.resolve(Cat.self)
                    return Dog()
                }
                container.register(Cat.self) {
                    identifiers.append(($0 as? Container)?.currentObjectGraph)
                    return Cat()
                }

                _ = container.resolve(Dog.self)

                expect(identifiers).to(haveCount(2))
                expect(identifiers[0]) == identifiers[1]
            }
            it("is nil outside the graph resolution") {
                container.register(Dog.self) { _ in Dog() }

                expect(container.currentObjectGraph).to(beNil())
                _ = container.resolve(Dog.self)
                expect(container.currentObjectGraph).to(beNil())
            }
        }
        describe("object graph restoration") {
            it("uses restored identifier during graph resolution") {
                let restoredIdentifier = GraphIdentifier()
                var identifier: GraphIdentifier?
                container.register(Dog.self) {
                    identifier = ($0 as? Container)?.currentObjectGraph
                    return Dog()
                }

                container.restoreObjectGraph(restoredIdentifier)
                _ = container.resolve(Dog.self)

                expect(identifier) == restoredIdentifier
            }
        }
        describe("instance storage interaction") {
            it("uses current graph identifier when manipulating instances") {
                let spy = StorageSpy()
                let graph = GraphIdentifier()
                let scope = ObjectScope(storageFactory: { spy })
                container.register(Dog.self) { _ in Dog() }.inObjectScope(scope)
                container.restoreObjectGraph(graph)

                _ = container.resolve(Dog.self)

                expect(spy.setterGraphs.last) == graph
                expect(spy.getterGraphs.last) == graph
            }
            it("restores instances from previous graphs if available") {
                var graph: GraphIdentifier!
                container.register(Dog.self) {
                    graph = ($0 as? Container)?.currentObjectGraph
                    return Dog()
                }.inObjectScope(.graph)

                let dog1 = container.resolve(Dog.self)!
                container.restoreObjectGraph(graph)
                let dog2 = container.resolve(Dog.self)!

                expect(dog1) === dog2
            }
        }
    }
}

private class StorageSpy: InstanceStorage {
    var setterGraphs = [GraphIdentifier]()
    var getterGraphs = [GraphIdentifier]()

    var instance: Any?
    func setInstance(_: Any?, inGraph graph: GraphIdentifier) {
        setterGraphs.append(graph)
    }

    func instance(inGraph graph: GraphIdentifier) -> Any? {
        getterGraphs.append(graph)
        return nil
    }
}
