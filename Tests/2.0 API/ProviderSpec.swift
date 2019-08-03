//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class ProviderSpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }
        describe("instance production") {
            it("provides instance from container") {
                container.register(Animal.self) { _ in Dog() }
                let provider = container.resolve(Provider<Animal>.self)
                expect(provider?.instance is Dog).to(beTrue())
            }
            it("does not create instance until requested") {
                var created = false
                container.register(Animal.self) { _ in created = true; return Dog() }

                _ = container.resolve(Provider<Animal>.self)

                expect(created).to(beFalse())
            }
            it("does not resolve provider if base type is not registered") {
                let provider = container.resolve(Provider<Animal>.self)
                expect(provider).to(beNil())
            }
        }
        describe("object scopes") {
            context("in transient scope") {
                it("resolves instance from the container each time") {
                    var created = 0
                    container.register(Animal.self) { _ in created += 1; return Dog() }
                        .inObjectScope(.transient)

                    let provider = container.resolve(Provider<Animal>.self)
                    _ = provider?.instance
                    _ = provider?.instance

                    expect(created) == 2
                }
                it("always produces different instance from different providers") {
                    EmploymentAssembly(scope: .transient).assemble(container: container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.providedEmployee.instance) !== employer.providedEmployee.instance
                    expect(employer.employee.providedCustomer.instance) !== employer.providedCustomer.instance
                }
            }
            context("in graph scope") {
                it("resolves instance from the container only once") {
                    var created = 0
                    container.register(Animal.self) { _ in created += 1; return Dog() }
                        .inObjectScope(.graph)

                    let provider = container.resolve(Provider<Animal>.self)
                    _ = provider?.instance
                    _ = provider?.instance

                    expect(created) == 1
                }
                it("always produces the same instance from different providers") {
                    EmploymentAssembly(scope: .graph).assemble(container: container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.providedEmployee.instance) === employer.providedEmployee.instance
                    expect(employer.employee.providedCustomer.instance) === employer.providedCustomer.instance
                }
            }
            context("in container scope") {
                it("resolves instance from the container only once") {
                    var created = 0
                    container.register(Animal.self) { _ in created += 1; return Dog() }
                        .inObjectScope(.container)

                    let provider = container.resolve(Provider<Animal>.self)
                    _ = provider?.instance
                    _ = provider?.instance

                    expect(created) == 1
                }
                it("always produces the same instance from different providers") {
                    EmploymentAssembly(scope: .container).assemble(container: container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.providedEmployee.instance) === employer.providedEmployee.instance
                    expect(employer.employee.providedCustomer.instance) === employer.providedCustomer.instance
                }
            }
        }
        describe("complex registrations") {
            it("resolves provider with arguments") {
                container.register(Dog.self) { (_, name, _: Int) in Dog(name: name) }
                let provider = container.resolve(Provider<Dog>.self, arguments: "Hachi", 42)
                expect(provider?.instance.name) == "Hachi"
            }
            it("resolves provider with name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                let provider = container.resolve(Provider<Dog>.self, name: "Hachi")
                expect(provider).notTo(beNil())
            }
            it("does not resolve provider with wrong name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                let provider = container.resolve(Provider<Dog>.self, name: "Mimi")
                expect(provider).to(beNil())
            }
            it("does resolve forwarded provider type") {
                container.register(Dog.self) { _ in Dog() }.implements(Animal.self)
                let provider = container.resolve(Provider<Animal>.self)
                expect(provider).notTo(beNil())
            }
        }
        describe("circular dependencies") {
            beforeEach {
                EmploymentAssembly(scope: .graph).assemble(container: container)
            }
            it("resolves dependencies to same instance") {
                let employer = container.resolve(Employer.self)
                expect(employer?.employee.employer) === employer
                expect(employer?.providedEmployee.instance.employer) === employer
            }
            it("resolves circular dependencies for lazy instance") {
                let employee = container.resolve(Provider<Employee>.self)
                expect(employee?.instance.employer).notTo(beNil())
            }
        }
    }
}
