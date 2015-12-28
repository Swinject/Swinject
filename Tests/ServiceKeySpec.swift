//
//  ServiceKeySpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ServiceKeySpec: QuickSpec {
    override func spec() {
        describe("Without name") {
            it("equals with the same factory type.") {
                typealias FactoryType0Args = Resolvable -> AnimalType
                let key1 = ServiceKey(factoryType: FactoryType0Args.self)
                let key2 = ServiceKey(factoryType: FactoryType0Args.self)
                expect(key1) == key2
                expect(key1.hashValue) == key2.hashValue
                
                typealias FactoryType2Args = (Resolvable, String, Bool) -> AnimalType
                let key3 = ServiceKey(factoryType: FactoryType2Args.self)
                let key4 = ServiceKey(factoryType: FactoryType2Args.self)
                expect(key3) == key4
                expect(key3.hashValue) == key4.hashValue
            }
            it("does not equal with different service types in factory types.") {
                typealias PersonFactoryType = Resolvable -> PersonType
                typealias AnimalFactoryType = Resolvable -> AnimalType
                let key1 = ServiceKey(factoryType: PersonFactoryType.self)
                let key2 = ServiceKey(factoryType: AnimalFactoryType.self)
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue
            }
            it("does not equal with different arg types in factory types.") {
                typealias FactoryType1Arg = (Resolvable, String) -> AnimalType
                typealias FactoryType2Args = (Resolvable, String, Bool) -> AnimalType
                let key1 = ServiceKey(factoryType: FactoryType1Arg.self)
                let key2 = ServiceKey(factoryType: FactoryType2Args.self)
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue
                
                typealias FactoryTypeStringBoolArgs = (Resolvable, String, Bool) -> AnimalType
                typealias FactoryTypeStringIntArgs = (Resolvable, String, Int) -> AnimalType
                let key3 = ServiceKey(factoryType: FactoryTypeStringBoolArgs.self)
                let key4 = ServiceKey(factoryType: FactoryTypeStringIntArgs.self)
                expect(key3) != key4
                expect(key3.hashValue) != key4.hashValue
            }
        }
        describe("With name") {
            it("equals with the same name.") {
                typealias FactoryType0Args = Resolvable -> AnimalType
                let key1 = ServiceKey(factoryType: FactoryType0Args.self, name: "my factory")
                let key2 = ServiceKey(factoryType: FactoryType0Args.self, name: "my factory")
                expect(key1) == key2
                expect(key1.hashValue) == key2.hashValue
                
                typealias FactoryType2Args = (Resolvable, String, Bool) -> AnimalType
                let key3 = ServiceKey(factoryType: FactoryType2Args.self, name: "my factory")
                let key4 = ServiceKey(factoryType: FactoryType2Args.self, name: "my factory")
                expect(key3) == key4
                expect(key3.hashValue) == key4.hashValue
            }
            it("does not equal with different names.") {
                typealias FactoryType0Args = Resolvable -> AnimalType
                let key1 = ServiceKey(factoryType: FactoryType0Args.self, name: "my factory")
                let key2 = ServiceKey(factoryType: FactoryType0Args.self, name: "your factory")
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue
                
                typealias FactoryType2Args = (Resolvable, String, Bool) -> AnimalType
                let key3 = ServiceKey(factoryType: FactoryType2Args.self, name: "my factory")
                let key4 = ServiceKey(factoryType: FactoryType2Args.self, name: "your factory")
                expect(key3) != key4
                expect(key3.hashValue) != key4.hashValue
            }
        }
    }
}
