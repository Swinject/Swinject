//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

// MARK: Option

private struct Option: ServiceKeyOption {
    let option: Int

    func isEqualTo(_ another: ServiceKeyOption) -> Bool {
        guard let another = another as? Option else {
            return false
        }

        return option == another.option
    }

    func hash(into hasher: inout Hasher) {
        option.hash(into: &hasher)
    }

    var description: String {
        return ""
    }
}

// MARK: ServiceKeySpec

class ServiceKeySpec: QuickSpec {
    override func spec() {
        describe("Without name") {
            it("equals with the same factory type.") {
                let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self)
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self)
                expect(key1) == key2
                expect(key1.hashValue) == key2.hashValue

                let key3 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
                let key4 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
                expect(key3) == key4
                expect(key3.hashValue) == key4.hashValue
            }
            it("does not equal with different service types in factory types.") {
                let key1 = ServiceKey(serviceType: Person.self, argumentsType: Resolver.self)
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self)
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue
            }
            it("does not equal with different arg types in factory types.") {
                let key1 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String).self)
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue

                let key3 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
                let key4 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Int).self)
                expect(key3) != key4
                expect(key3.hashValue) != key4.hashValue
            }
        }
        describe("With name") {
            it("equals with the same name.") {
                let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "my factory")
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "my factory")
                expect(key1) == key2
                expect(key1.hashValue) == key2.hashValue

                let key3 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    name: "my factory"
                )
                let key4 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    name: "my factory"
                )
                expect(key3) == key4
                expect(key3.hashValue) == key4.hashValue
            }
            it("does not equal with different names.") {
                let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "my factory")
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "your factory")
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue

                let key3 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    name: "my factory"
                )
                let key4 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    name: "your factory"
                )
                expect(key3) != key4
                expect(key3.hashValue) != key4.hashValue
            }
        }
        describe("With option") {
            it("equals with the same option.") {
                let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 1))
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 1))
                expect(key1) == key2
                expect(key1.hashValue) == key2.hashValue

                let key3 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    option: Option(option: 1)
                )
                let key4 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    option: Option(option: 1)
                )
                expect(key3) == key4
                expect(key3.hashValue) == key4.hashValue
            }
            it("does not equal with different options.") {
                let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 1))
                let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 2))
                expect(key1) != key2
                expect(key1.hashValue) != key2.hashValue

                let key3 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    option: Option(option: 1)
                )
                let key4 = ServiceKey(
                    serviceType: Animal.self,
                    argumentsType: (Resolver, String, Bool).self,
                    option: Option(option: 2)
                )
                expect(key3) != key4
                expect(key3.hashValue) != key4.hashValue
            }
        }
    }
}
