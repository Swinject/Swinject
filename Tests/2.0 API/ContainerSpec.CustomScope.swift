//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ContainerSpec_CustomScope: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("Resolving from custom scope") {
            it("creates new instance storage for each service") {
                var instances = 0
                let custom = ObjectScope(storageFactory: { instances += 1; return FakeStorage() })

                container.register(Int.self) { _ in 0 }.inObjectScope(custom)
                container.register(Double.self) { _ in 0 }.inObjectScope(custom)
                _ = container.resolve(Int.self)
                _ = container.resolve(Double.self)

                expect(instances) == 2
            }
            it("stores instance to storage during resolution") {
                let storage = FakeStorage()
                let custom = ObjectScope(storageFactory: { storage })

                container.register(Int.self) { _ in 42 }.inObjectScope(custom)
                _ = container.resolve(Int.self)

                expect(storage.instance as? Int) == 42
            }
            it("returns stored instance if storage is not empty") {
                let storage = FakeStorage()
                let custom = ObjectScope(storageFactory: { storage })

                container.register(Int.self) { _ in 0 }.inObjectScope(custom)
                storage.instance = 42
                let result = container.resolve(Int.self)

                expect(result) == 42
            }
        }
        describe("Resetting scope") {
            it("removes instance from services in given scope") {
                let storage = FakeStorage()
                let custom = ObjectScope(storageFactory: { storage })

                container.register(Int.self) { _ in 0 }.inObjectScope(custom)
                storage.instance = 42
                container.resetObjectScope(custom)

                expect(storage.instance).to(beNil())
            }
            it("does not remove instances from other scopes") {
                let storage = FakeStorage()
                let custom1 = ObjectScope(storageFactory: { storage })
                let custom2 = ObjectScope(storageFactory: FakeStorage.init)

                container.register(Int.self) { _ in 0 }.inObjectScope(custom1)
                storage.instance = 42
                container.resetObjectScope(custom2)

                expect(storage.instance as? Int) == 42
            }
            it("removes instance from service registered in parent container") {
                let storage = FakeStorage()
                let custom = ObjectScope(storageFactory: { storage })
                let child = Container(parent: container)

                container.register(Int.self) { _ in 0 }.inObjectScope(custom)
                storage.instance = 42
                child.resetObjectScope(custom)

                expect(storage.instance).to(beNil())
            }
        }
    }
}

private class FakeStorage: InstanceStorage {
    var instance: Any?
}
