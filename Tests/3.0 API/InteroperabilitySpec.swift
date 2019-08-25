//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import class Swinject.UnboundScope

class InteroperabilitySpec: QuickSpec { override func spec() { #if swift(>=5.1)
    it("can resolve module bindings from assembler") {
        let module = Swinject.Module("") {
            register().constant(42)
        }
        let assembler = Assembler([module])
        expect(assembler.resolver.resolve(Int.self)) == 42
    }
    it("can use module bindings from other assemblies") {
        let module = Swinject.Module("") {
            register().constant(42)
        }
        struct OtherAssembly: Assembly {
            func assemble(container: Container) {
                container.register(Double.self) { Double($0.resolve(Int.self)!) }
            }
        }
        let assembler = Assembler([module, OtherAssembly()])
        expect(assembler.resolver.resolve(Double.self)) == 42
    }
    it("can use assembly bindings in module") {
        let module = Swinject.Module("") {
            register().resultOf(Double.init ^ instance(of: Int.self))
        }
        struct OtherAssembly: Assembly {
            func assemble(container: Container) {
                container.register(Int.self) { _ in 42 }
            }
        }
        let assembler = Assembler([module, OtherAssembly()])
        expect(assembler.resolver.resolve(Double.self)) == 42
    }
    it("can use 3.0 injection api with container") {
        let container = Container {
            $0.register(Int.self) { _ in 42 }
        }
        expect { try instance(of: Int.self).from(container) } == 42
    }
    describe("singletons") {
        beforeEach {
            UnboundScope.root.close()
        }
        struct Dependencies: Assembly {
            func assemble(container: Container) {
                container.register(String.self) { _ in "mimi" }
                container.register(Human.self) { _ in Human() }
            }
        }
        it("can use unscoped singletons") {
            let module = Swinject.Module("") {
                registerSingle().resultOf(Pet.init^)
            }
            let assembler = Assembler([module, Dependencies()])

            let first = try? instance(of: Pet.self).from(assembler.resolver)
            let second = try? instance(of: Pet.self).from(assembler.resolver)

            expect(first) === second
        }
        it("can use singletons in scope without context") {
            let scope = UnboundScope()
            let module = Swinject.Module("") {
                registerSingle(in: scope).resultOf(Pet.init^)
            }
            let assembler = Assembler([module, Dependencies()])

            let first = try? instance(of: Pet.self).from(assembler.resolver)
            let second = try? instance(of: Pet.self).from(assembler.resolver)

            expect(first) === second
        }
        it("cannot use scopes with context if dependencies are defined in assembly") {
            let sessionScope = SessionScope()
            let session = Session()
            let module = Swinject.Module("") {
                registerSingle(in: sessionScope).resultOf(Pet.init^)
            }
            let assembler = Assembler([module, Dependencies()])

            expect { try instance(of: Pet.self).from(assembler.resolver.on(session)) }.to(throwError())
        }
        it("cannot use contexts if dependencies are defined in assembly") {
            let module = Swinject.Module("") {
                register(inContextOf: String.self).resultOf(Pet.init^)
            }
            let assembler = Assembler([module, Dependencies()])

            expect { try instance(of: Pet.self).from(assembler.resolver.on("context")) }.to(throwError())
        }
    }
    #endif
} }
