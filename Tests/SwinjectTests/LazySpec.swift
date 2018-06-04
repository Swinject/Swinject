//
//  LazySpec.swift
//  Swinject
//
//  Created by Jakub Vaňo on 07/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
// swiftlint:disable function_body_length

import Quick
import Nimble
import Swinject

class LazySpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("instance production") {
            it("provides instance from container") {
                container.register(Animal.self) { _ in Dog() }
                let lazy = container.resolve(Lazy<Animal>.self)
                expect(lazy?.instance is Dog).to(beTrue())
            }
            it("does not create instance until requested") {
                var created = false
                container.register(Animal.self) { _ in created = true; return Dog() }

                _ = container.resolve(Lazy<Animal>.self)

                expect(created).to(beFalse())
            }
            it("resolves instance from container only once") {
                var created = 0
                container.register(Animal.self) { _ in created += 1; return Dog() }

                let lazy = container.resolve(Lazy<Animal>.self)
                _ = lazy?.instance
                _ = lazy?.instance

                expect(created) == 1
            }
            it("does not resolve lazy if base type is not registered") {
                let lazy = container.resolve(Lazy<Animal>.self)
                expect(lazy).to(beNil())
            }
        }
        describe("object scopes") {
            context("in transient scope") {
                it("always produces different instance for related objects") {
                    EmploymentAssembly(scope: .transient).assemble(container: container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.lazyCustomer.instance).notTo(beIdenticalTo(employer.employee.lazyCustomer.instance))
                    expect(employer.lazyCustomer.instance).notTo(beIdenticalTo(employer.customer))
                }
            }
            context("in container scope") {
                it("always produces the same instance for related objects") {
                    EmploymentAssembly(scope: .container).assemble(container: container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.employee.lazyCustomer.instance))
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.customer))
                }
            }
            context("in graph scope") {
                it("always produces the same instance for related objects") {
                    EmploymentAssembly(scope: .graph).assemble(container: container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.employee.lazyCustomer.instance))
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.customer))
                }
            }
        }
        describe("complex registrations") {
            it("resolves lazy with arguments") {
                container.register(Dog.self) { (_, name, _: Int) in  Dog(name: name) }
                let lazy = container.resolve(Lazy<Dog>.self, arguments: "Hachi", 42)
                expect(lazy?.instance.name) == "Hachi"
            }
            it("resolves lazy with name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                let lazy = container.resolve(Lazy<Dog>.self, name: "Hachi")
                expect(lazy).notTo(beNil())
            }
            it("does not resolve lazy with wrong name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                let lazy = container.resolve(Lazy<Dog>.self, name: "Mimi")
                expect(lazy).to(beNil())
            }
            it("does resolve forwarded lazy type") {
                container.register(Dog.self) { _ in Dog() }.implements(Animal.self)
                let lazy = container.resolve(Lazy<Animal>.self)
                expect(lazy).notTo(beNil())
            }
        }
        describe("circular dependencies") {
            beforeEach {
                EmploymentAssembly(scope: .graph).assemble(container: container)
            }
            it("resolves dependencies to same instance") {
                let employer = container.resolve(Employer.self)
                expect(employer?.employee.employer) === employer
                expect(employer?.lazyEmployee.instance.employer) === employer
            }
            it("resolves circular dependencies for lazy instance") {
                let employee = container.resolve(Lazy<Employee>.self)
                expect(employee?.instance.employer).notTo(beNil())
            }
        }
    }
}
