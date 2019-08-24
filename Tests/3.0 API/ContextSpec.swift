//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import class Swinject.UnboundScope

class ContextSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can pass context to the bindings") {
        let swinject = Swinject {
            register(inContextOf: String.self).factory { try Int($0.context())! }
            register(inContextOf: String.self).factory { try Double($0.context())! + Double($1 as Int) }
        }
        expect { try swinject.on("42").instance(of: Int.self) } == 42
        expect { try swinject.on("25").instance(of: Double.self, arg: 17) } == 42
    }
    it("throws if injecting on the wrong context") {
        let swinject = Swinject {
            register(inContextOf: Double.self).factory { try Int($0.context()) }
        }
        expect { try swinject.on("context").instance(of: Int.self) }.to(throwError())
    }
    it("does not invoke bindings on other contexts") {
        var invoked = false
        let swinject = Swinject {
            register(inContextOf: String.self).factory { 42 }
            register(inContextOf: Double.self).factory(for: Int.self) {
                invoked = true
                return 42
            }
        }
        _ = try? swinject.on("context").instance(of: Int.self)
        expect(invoked) == false
    }
    it("can use binding without context in any context") {
        let swinject = Swinject {
            register().constant(42)
        }
        expect { try swinject.on("context").instance() as Int } == 42
        expect { try swinject.on(Human()).instance() as Int } == 42
    }
    it("passes context to the dependencies") {
        let john = Human()
        let swinject = Swinject {
            register(inContextOf: String.self).factory { try $0.context() == "john" ? john : Human() }
            register().factory { Pet(owner: try $0.instance()) }
        }
        let pet = try? swinject.on("john").instance(of: Pet.self)
        expect(pet?.owner) === john
    }
    describe("translators") {
        it("can translate contexts") {
            let john = Human()
            let swinject = Swinject {
                register(inContextOf: Human.self).factory { try Pet(owner: $0.context()) }
                registerContextTranslator(from: String.self) { $0 == "john" ? john : Human() }
            }
            let pet = try? swinject.on("john").instance(of: Pet.self)
            expect(pet?.owner) === john
        }
        it("throws if translator has incorrect types") {
            let swinject = Swinject {
                register(inContextOf: String.self).factory { try Int($0.context())! }
                registerContextTranslator(from: Float.self) { String($0) }
                registerContextTranslator(from: Double.self) { Int($0) }
            }
            expect { try swinject.on(42.0).instance(of: Int.self) }.to(throwError())
        }
        it("throws if multiple bindings could be used with translated contexts") {
            let swinject = Swinject {
                register(inContextOf: Float.self).factory { try Int($0.context()) }
                register(inContextOf: Double.self).factory { try Int($0.context()) }
                registerContextTranslator(from: String.self) { Float($0)! }
                registerContextTranslator(from: String.self) { Double($0)! }
            }
            expect { try swinject.on("42").instance(of: Int.self) }.to(throwError())
        }
        it("throws if has binding on given context and translator leading to other binding") {
            let swinject = Swinject {
                register(inContextOf: String.self).factory { try Int($0.context())! }
                register(inContextOf: Double.self).factory { try Int($0.context()) }
                registerContextTranslator(from: String.self) { Double($0)! }
            }
            expect { try swinject.on("42").instance(of: Int.self) }.to(throwError())
        }
        it("does not throw if multiple translators lead to the same binding") {
            let swinject = Swinject {
                register(inContextOf: Any.self).factory { 42 }
                registerContextTranslator(from: Double.self) { "\($0)" }
                registerContextTranslator(from: Double.self) { Float($0) }
            }
            expect { try swinject.on(42.0).instance(of: Int.self) }.notTo(throwError())
        }
    }
    #endif
} }
