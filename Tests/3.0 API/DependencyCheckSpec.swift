//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

// swiftformat:disable spaceAroundOperators
class DependencyCheckSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    let john = Human()
    describe("checked factory") {
        it("can declaratively specify binding's factory") {
            let swinject = Swinject {
                register().constant("mimi")
                register().constant(john)
                register().resultOf(Pet.init^)
            }
            let pet = try? instance(of: Pet.self).from(swinject)
            expect(pet?.name) == "mimi"
            expect(pet?.owner) === john
        }
        it("can declare specific input requests") {
            let swinject = Swinject {
                register().constant("mimi", tag: "name")
                register().factory { $1 == "john" ? john : Human() }
                register().resultOf(
                    Pet.init^(name: instance(tagged: "name"), owner: instance(arg: "john"))
                )
            }
            let pet = try? instance(of: Pet.self).from(swinject)
            expect(pet?.name) == "mimi"
            expect(pet?.owner) === john
        }
        it("can require arguments as function inputs") {
            let swinject = Swinject {
                register().resultOf(
                    Pet.init^(name: argument(0), owner: argument(1))
                )
            }
            let pet = try? instance(of: Pet.self, arg: "mimi", john).from(swinject)
            expect(pet?.name) == "mimi"
            expect(pet?.owner) === john
        }
        it("can require context as function input") {
            let swinject = Swinject {
                register().constant("mimi")
                register(inContextOf: Human.self).resultOf(
                    Pet.init^(name: instance(), owner: context())
                )
            }
            let pet = try? instance(of: Pet.self).from(swinject.on(john))
            expect(pet?.name) == "mimi"
            expect(pet?.owner) === john
        }
    }
    describe("checked property injection") {
        it("can specify property injection in binding declaration") {
            let swinject = Swinject {
                register().constant("john")
                register().constant(42, tag: "age")
                register()
                    .resultOf(Human.init^)
                    .injectedBy(
                        \.name <- instance(),
                        \.age <- instance(tagged: "age")
                    )
            }
            let human = try? instance(of: Human.self).from(swinject)
            expect(human?.name) == "john"
            expect(human?.age) == 42
        }
        it("can use arguments for property injection") {
            let swinject = Swinject {
                register()
                    .resultOf(Human.init^)
                    .injectedBy(
                        \.name <- argument(0),
                        \.age <- argument(1)
                    )
            }
            let human = try? instance(of: Human.self, arg: "john", 42).from(swinject)
            expect(human?.name) == "john"
            expect(human?.age) == 42
        }
        it("can use context for property injection") {
            let swinject = Swinject {
                register().constant(42)
                register(inContextOf: String.self)
                    .resultOf(Human.init^)
                    .injectedBy(
                        \.name <- context(),
                        \.age <- instance()
                    )
            }
            let human = try? instance(of: Human.self).from(swinject.on("john"))
            expect(human?.name) == "john"
            expect(human?.age) == 42
        }
    }
    describe("dependency check") {
        it("fails if checked binding has missing dependency") {
            expect {
                _ = Swinject {
                    register().resultOf(Pet.init^)
                }
            }.to(throwAssertion())
        }
        it("fails if checked binding's dependency is registerd with wrong tag") {
            expect {
                _ = Swinject {
                    register().constant(john)
                    register().constant("mimi", tag: "name")
                    register().resultOf(Pet.init^)
                }
            }.to(throwAssertion())
        }
        it("fails if checked binding's dependency is registerd with wrong arguments") {
            expect {
                _ = Swinject {
                    register().factory { $1 == "john" ? john : Human() }
                    register().constant("mimi")
                    register().resultOf(Pet.init^)
                }
            }.to(throwAssertion())
        }
        it("fails if checked binding has missing property injection dependency") {
            expect {
                _ = Swinject {
                    register().resultOf(Human.init^).injectedBy(\.name <- instance())
                }
            }.to(throwAssertion())
        }
    }
    #endif
} }
