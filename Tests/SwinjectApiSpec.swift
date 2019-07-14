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
        it("throws for empty swinject") {
            let swinject = Swinject { }
            expect { try swinject.inject(42) }.to(throwError())
        }
        it("does not throw if has bound injector") {
            let swinject = Swinject {
                bbind(Int.self) & injector { _ in }
            }
            expect { try swinject.inject(42) }.notTo(throwError())
        }
        it("trows if does not have bound injector") {
            let swinject = Swinject {
                bbind(Double.self) & injector { _ in }
                bbind(Int.self) & IntManipulator()
            }
            expect { try swinject.inject(42) }.to(throwError())
        }
        it("injects intance using bound injector") {
            let swinject = Swinject {
                bbind(Person.self) & injector { $0.age = 42 }
            }
            try? swinject.inject(person)
            expect(person.age) == 42
        }
        it("throws if injecting type with missing dependency") {
            let swinject = Swinject {
                bbind(Person.self) & injector { $0.age = try $1.instance() }
            }
            expect { try swinject.inject(Person()) }.to(throwError())
        }
        it("injects dependency with bound provider") {
            let swinject = Swinject {
                bbind(Person.self) & injector { $0.age = try $1.instance() }
                bbind(Int.self).with(42)
            }
            try? swinject.inject(person)
            expect(person.age) == 42
        }
        it("injects instance using all bound injectors") {
            let swinject = Swinject {
                bbind(Person.self) & injector { $0.age = 42 }
                bbind(Person.self) & injector { $0.height = 123.4 }
                bbind(Person.self) & injector { $0.name = "name" }
            }
            try? swinject.inject(person)
            expect(person.age) == 42
            expect(person.height) == 123.4
            expect(person.name) == "name"
        }
        it("throws if injecting type with wrong tag") {
            let swinject = Swinject {
                bbind(Person.self, tagged: "Tag") & injector { $0.age = 42 }
            }
            expect { try swinject.inject(person) }.to(throwError())
            expect { try swinject.inject(person, tagged: 42) }.to(throwError())
            expect { try swinject.inject(person, tagged: "OtherTag") }.to(throwError())
        }
        // TODO: Arguments
    }
    describe("type provision") {
        it("throws for empty swinject") {
            let swinject = Swinject { }
            expect { try swinject.instance(of: Int.self) }.to(throwError())
        }
        it("returns instance if provider is bound") {
            let swinject = Swinject {
                bbind(Int.self).with(42)
            }
            expect { try swinject.instance(of: Int.self) } == 42
        }
        it("throws if providing type with missing dependency") {
            let swinject = Swinject {
                bbind(Pet.self) & factory { Pet(owner: try $0.instance()) }
            }
            expect { try swinject.instance(of: Pet.self) }.to(throwError())
        }
        it("returns instance from bound dependency provider") {
            let swinject = Swinject {
                bbind(Pet.self) & factory { Pet(owner: try $0.instance()) }
                bbind(Person.self) & person
            }
            expect { try swinject.instance(of: Pet.self).owner } === person
        }
        it("throws if multiple providers are bound") {
            let swinject = Swinject {
                bbind(Int.self) & 42
                bbind(Int.self) & factory { 17 + 25 }
            }
            expect { try swinject.instance(of: Int.self) }.to(throwError())
        }
        it("throws if requesting instance with wrong tag") {
            let swinject = Swinject {
                bbind(Int.self, tagged: "Tag") & 42
            }
            expect { try swinject.instance(of: Int.self) }.to(throwError())
            expect { try swinject.instance(of: Int.self, tagged: 42) }.to(throwError())
            expect { try swinject.instance(of: Int.self, tagged: "OtherTag") }.to(throwError())
        }
        it("injects provided instance using bound injectors") {
            let swinject = Swinject {
                bbind(Person.self) & Person()
                bbind(Person.self) & injector { $0.age = 42 }
                bbind(Person.self) & injector { $0.height = 123.4 }
                bbind(Person.self) & injector { $0.name = "Name" }
            }
            let person = try? swinject.instance() as Person
            expect(person?.age) == 42
            expect(person?.height) == 123.4
            expect(person?.name) == "Name"
        }
        it("throws if type has bound injector with missing dependency") {
            let swinject = Swinject {
                bbind(Person.self) & Person()
                bbind(Person.self) & injector { $0.age = try $1.instance() }
            }
            expect { try swinject.instance(of: Person.self) }.to(throwError())
        }
        it("can reuse provider for multiple descriptors") {
            let personProvider = vvalue(person) // @functionBuilder does not support declarations in closures yet
            let swinject = Swinject {
                bbind(Person.self) & personProvider
                bbind(AnyObject.self) & personProvider.map { $0 as AnyObject }
            }
            expect { try swinject.instance(of: Person.self) } === person
            expect { try swinject.instance(of: AnyObject.self) } === person
        }
        it("provides passed dependency during instance provision") {
            let swinject = Swinject {
                bbind(Pet.self) & factory { try Pet(owner: $0.instance()) }
            }
            let pet = try? swinject.instance(with: person) as Pet
            expect(pet?.owner) === person
        }
        it("does not throw if passed dependency type already has a bound provider") {
            let swinject = Swinject {
                bbind(Pet.self) & factory { try Pet(owner: $0.instance()) }
                bbind(Person.self) & person
            }
            expect { try swinject.instance(of: Pet.self, with: person) }.notTo(throwError())
        }
        it("uses passed dependency if type already has a bound provider") {
            let swinject = Swinject {
                bbind(Pet.self) & factory { try Pet(owner: $0.instance()) }
                bbind(Person.self) & factory { Person() }
            }
            let pet = try? swinject.instance(with: person) as Pet
            expect(pet?.owner) === person
        }
        it("does not inject passed dependency") {
            let swinject = Swinject {
                bbind(Pet.self) & factory { try Pet(owner: $0.instance()) }
                bbind(Person.self) & factory { Person() }
                bbind(Person.self) & injector { $0.age = 42 }
            }
            let pet = try? swinject.instance(with: person) as Pet
            expect(pet?.owner.age) == 0
        }
        // TODO: Multiple dependencies
        // TODO: Reuse binding request for multiple manipulators?
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
