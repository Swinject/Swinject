//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Swinject

class WeakStorageSpec: QuickSpec {
    override func spec() {
        var storage: WeakStorage!
        beforeEach {
            storage = WeakStorage()
        }

        describe("Storing reference type") {
            context("there is strong reference to instance") {
                it("should provide stored instance") {
                    let object = DummyObject()
                    storage.instance = object
                    expect(storage.instance as? DummyObject) === object
                }
            }
            context("there is no strong reference to instace") {
                it("should not persist instance") {
                    storage.instance = DummyObject()
                    expect(storage.instance).to(beNil())
                }
            }
            context("there is weak reference to instace") {
                it("should not persist instance") {
                    var object: DummyObject? = DummyObject()
                    weak var weakObject = object
                    storage.instance = object

                    object = nil

                    expect(storage.instance).to(beNil())
                    expect(weakObject).to(beNil())
                }
            }
        }

        describe("Storing value type") {
            it("should not persist instance") {
                let value = DummyStruct()
                storage.instance = value
                expect(storage.instance).to(beNil())
            }
        }
    }
}

private struct DummyStruct {}
private class DummyObject {}
