//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
import Swinject3

class SwinjectApiSpec: QuickSpec { override func spec() {
    describe("property injection") {
        var person = Person()
        beforeEach {
            person = Person()
        }
        it("throws for empty container") {
            let container = Swinject3.container { }
            expect { try container.inject(42) }.to(throwError())
        }
        it("does not throw if has required injector") {
            let container = Swinject3.container {
                bbind(Int.self) & injector { _ in }
            }
            expect { try container.inject(42) }.notTo(throwError())
        }
        it("trows if does not have required injector") {
            let container = Swinject3.container {
                bbind(Double.self) & injector { _ in }
                bbind(Int.self) & IntManipulator()
            }
            expect { try container.inject(42) }.to(throwError())
        }
        it("injects intance using provided injector") {
            let container = Swinject3.container {
                bbind(Person.self) & injector { $0.age = 42 }
            }
            try? container.inject(person)
            expect(person.age) == 42
        }
        it("throws if injecting type with missing dependency") {
            let container = Swinject3.container {
                bbind(Person.self) & injector { $0.age = try $1.instance() }
            }
            expect { try container.inject(Person()) }.to(throwError())
        }
        it("injects dependency with defined provider") {
            let container = Swinject3.container {
                bbind(Person.self) & injector { $0.age = try $1.instance() }
                bbind(Int.self).with(42)
            }
            try? container.inject(person)
            expect(person.age) == 42
        }
        it("injects instance using all defined injectors") {
            let container = Swinject3.container {
                bbind(Person.self) & injector { $0.age = 42 }
                bbind(Person.self) & injector { $0.height = 123.4 }
                bbind(Person.self) & injector { $0.name = "name" }
            }
            try? container.inject(person)
            expect(person.age) == 42
            expect(person.height) == 123.4
            expect(person.name) == "name"
        }
        it("throws if injecting type with wrong tag") {
            let container = Swinject3.container {
                bbind(Person.self, tagged: "Tag") & injector { $0.age = 42 }
            }
            expect { try container.inject(person) }.to(throwError())
            expect { try container.inject(person, tagged: 42) }.to(throwError())
            expect { try container.inject(person, tagged: "OtherTag") }.to(throwError())
        }
        // TODO: Arguments
    }
    describe("type provision") {
        it("throws for empty container") {
            let container = Swinject3.container { }
            expect { try container.instance(of: Int.self) }.to(throwError())
        }
        it("returns instance if provider is defined") {
            let container = Swinject3.container {
                bbind(Int.self).with(42)
            }
            expect { try container.instance(of: Int.self) } == 42
        }
        it("throws if providing type with missing dependency") {
            let container = Swinject3.container {
                bbind(Pet.self) & factory { Pet(owner: try $0.instance()) }
            }
            expect { try container.instance(of: Pet.self) }.to(throwError())
        }
        it("returns instance with defined dependency provider") {
            let person = Person()
            let container = Swinject3.container {
                bbind(Pet.self) & factory { Pet(owner: try $0.instance()) }
                bbind(Person.self) & person
            }
            expect { try container.instance(of: Pet.self).owner } === person
        }
        it("throws if multiple providers are defined") {
            let container = Swinject3.container {
                bbind(Int.self) & 42
                bbind(Int.self) & factory { 17 + 25 }
            }
            expect { try container.instance(of: Int.self) }.to(throwError())
        }
        it("throws if requesting instance with wrong tag") {
            let container = Swinject3.container {
                bbind(Int.self, tagged: "Tag") & 42
            }
            expect { try container.instance(of: Int.self) }.to(throwError())
            expect { try container.instance(of: Int.self, tagged: 42) }.to(throwError())
            expect { try container.instance(of: Int.self, tagged: "OtherTag") }.to(throwError())
        }
        // TODO: Injectors during intantiation
        // TODO: Reuse provider for multiple type descriptors
        // TODO: Arguments
    }
}}

class Person {
    var age = 0
    var height = 0.0
    var name = ""
}

struct Pet {
    let owner: Person
}
