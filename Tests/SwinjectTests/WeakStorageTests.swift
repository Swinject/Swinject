//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class WeakStorageTests: XCTestCase {
    // MARK: Storing reference type

    func testWeakStorageShouldProvideStoredInstanceWithStrongReference() {
        let object = DummyObject()
        let storage = WeakStorage()
        storage.instance = object
        XCTAssert(storage.instance as? DummyObject === object)
    }

    func testWeakStorageShouldNotPersistInstanceWithoutStrongReference() {
        let storage = WeakStorage()
        storage.instance = DummyObject()
        XCTAssertNil(storage.instance)
    }

    func testWeakStorageShouldNotPersistInstanceWithWeakReference() {
        var object: DummyObject? = DummyObject()
        weak var weakObject = object
        let storage = WeakStorage()
        storage.instance = object

        object = nil

        XCTAssertNil(storage.instance)
        XCTAssertNil(weakObject)
    }

    // MARK: Storing value type

    func testWeakStorageShouldNotPersistInstance() {
        let value = DummyStruct()
        let storage = WeakStorage()
        storage.instance = value
        XCTAssertNil(storage.instance)
    }
}

private struct DummyStruct {}
private class DummyObject {}
