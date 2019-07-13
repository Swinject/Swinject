//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
import Swinject3

class SwinjectApiSpec: QuickSpec { override func spec() {
    describe("property injection") {
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
            let person = Person()
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
            let person = Person()
            try? container.inject(person)
            expect(person.age) == 42
        }
        // TODO: Tags
        // TODO: Multiple type injectors
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
        // TODO: injectors during intantiation
        // TODO: Tags
        // TODO: Multiple type providers
        // TODO: Arguments
    }
}}

class Person {
    var age = 0
}

struct Pet {
    let owner: Person
}
