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
    describe("injection") {
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
