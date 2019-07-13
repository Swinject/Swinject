//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
import Swinject3

class SwinjectApiSpec: QuickSpec { override func spec() {
    var person = Person()
    beforeEach {
        person = Person()
    }
    describe("property injection") {
        it("throws for empty container") {
            let container = Swinject3.container { }
            expect { try container.inject(42) }.to(throwError())
        }
        it("does not throw if has bound injector") {
            let container = Swinject3.container {
                bbind(Int.self) & injector { _ in }
            }
            expect { try container.inject(42) }.notTo(throwError())
        }
        it("trows if does not have bound injector") {
            let container = Swinject3.container {
                bbind(Double.self) & injector { _ in }
                bbind(Int.self) & IntManipulator()
            }
            expect { try container.inject(42) }.to(throwError())
        }
        it("injects intance using bound injector") {
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
        it("injects dependency with bound provider") {
            let container = Swinject3.container {
                bbind(Person.self) & injector { $0.age = try $1.instance() }
                bbind(Int.self).with(42)
            }
            try? container.inject(person)
            expect(person.age) == 42
        }
        it("injects instance using all bound injectors") {
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
        it("returns instance if provider is bound") {
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
        it("returns instance from bound dependency provider") {
            let container = Swinject3.container {
                bbind(Pet.self) & factory { Pet(owner: try $0.instance()) }
                bbind(Person.self) & person
            }
            expect { try container.instance(of: Pet.self).owner } === person
        }
        it("throws if multiple providers are bound") {
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
        // TODO: Reuse provider for multiple type descriptors
        it("injects provided instance using bound injectors") {
            let container = Swinject3.container {
                bbind(Person.self) & Person()
                bbind(Person.self) & injector { $0.age = 42 }
                bbind(Person.self) & injector { $0.height = 123.4 }
                bbind(Person.self) & injector { $0.name = "Name" }
            }
            let person = try? container.instance() as Person
            expect(person?.age) == 42
            expect(person?.height) == 123.4
            expect(person?.name) == "Name"
        }
        it("throws if type has bound injector with missing dependency") {
            let container = Swinject3.container {
                bbind(Person.self) & Person()
                bbind(Person.self) & injector { $0.age = try $1.instance() }
            }
            expect { try container.instance(of: Person.self) }.to(throwError())
        }
        // TODO: Reuse binding request for multiple manipulators?
        // TODO: Arguments
        // TODO: Less verbose type forwading API?
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
