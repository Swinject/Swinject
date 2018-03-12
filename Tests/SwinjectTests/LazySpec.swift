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
                container.register(Animal.self) { _ in Dog() }.enableLazy()

                let lazy = container.resolve(Lazy<Animal>.self)

                expect(lazy?.instance is Dog).to(beTrue())
            }
            it("does not create instance until requested") {
                var created = false
                container.register(Animal.self) { _ in created = true; return Dog() }
                    .enableLazy()

                _ = container.resolve(Lazy<Animal>.self)

                expect(created).to(beFalse())
            }
            it("resolves instance from container only once") {
                var created = 0
                container.register(Animal.self) { _ in created += 1; return Dog() }
                    .enableLazy()

                let lazy = container.resolve(Lazy<Animal>.self)
                _ = lazy?.instance
                _ = lazy?.instance

                expect(created) == 1
            }
        }
        describe("object scopes") {
            func setup(_ scope: ObjectScope) {
                container.register(Customer.self) { _ in Customer() }
                    .inObjectScope(scope)
                    .enableLazy()

                container.register(Employee.self) {
                    Employee(
                        customer: $0.resolve(Customer.self)!,
                        lazyCustomer: $0.resolve(Lazy<Customer>.self)!
                    )
                }.inObjectScope(scope).enableLazy()

                container.register(Employer.self) {
                    Employer(
                        customer: $0.resolve(Customer.self)!,
                        lazyCustomer: $0.resolve(Lazy<Customer>.self)!,
                        employee: $0.resolve(Employee.self)!,
                        lazyEmployee: $0.resolve(Lazy<Employee>.self)!
                    )
                }.inObjectScope(scope).enableLazy()
            }

            context("in transient scope") {
                it("always produces different instance for related objects") {
                    setup(.transient)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.lazyCustomer.instance).notTo(beIdenticalTo(employer.employee.lazyCustomer.instance))
                    expect(employer.lazyCustomer.instance).notTo(beIdenticalTo(employer.customer))
                }
            }
            context("in container scope") {
                it("always produces the same instance for related objects") {
                    setup(.container)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.employee.lazyCustomer.instance))
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.customer))
                }
            }
            context("in graph scope") {
                it("always produces the same instance for related objects") {
                    setup(.graph)
                    let employer = container.resolve(Employer.self)!
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.employee.lazyCustomer.instance))
                    expect(employer.lazyCustomer.instance).to(beIdenticalTo(employer.customer))
                }
            }
        }
        describe("complex registrations") {
            it("resolves lazy with arguments") {
                container.register(Dog.self) { (_, name, _: Int) in  Dog(name: name) }
                    .enableLazy()

                let lazy = container.resolve(Lazy<Dog>.self, arguments: "Hachi", 42)

                expect(lazy?.instance.name) == "Hachi"
            }
            it("resolves lazy with name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                    .enableLazy()

                let lazy = container.resolve(Lazy<Dog>.self, name: "Hachi")

                expect(lazy).notTo(beNil())
            }
            it("does not resolve lazy with wrong name") {
                container.register(Dog.self, name: "Hachi") { _ in Dog() }
                    .enableLazy()

                let lazy = container.resolve(Lazy<Dog>.self, name: "Mimi")

                expect(lazy).to(beNil())
            }
        }
    }
}

class Customer {}

class Employee {
    let customer: Customer
    let lazyCustomer: Lazy<Customer>

    init(customer: Customer, lazyCustomer: Lazy<Customer>) {
        self.customer = customer
        self.lazyCustomer = lazyCustomer
    }
}

class Employer {
    let customer: Customer
    let lazyCustomer: Lazy<Customer>
    let employee: Employee
    let lazyEmployee: Lazy<Employee>

    init(customer: Customer, lazyCustomer: Lazy<Customer>, employee: Employee, lazyEmployee: Lazy<Employee>) {
        self.customer = customer
        self.lazyCustomer = lazyCustomer
        self.employee = employee
        self.lazyEmployee = lazyEmployee
    }
}
