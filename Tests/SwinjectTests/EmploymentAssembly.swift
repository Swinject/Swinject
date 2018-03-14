//
//  Employment.swift
//  Swinject
//
//  Created by Jakub Vaňo on 14/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

import Swinject

class Customer {}

class Employee {
    let customer: Customer
    let lazyCustomer: Lazy<Customer>
    weak var employer: Employer?

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

final class EmploymentAssembly: Assembly {
    private let scope: ObjectScope

    init(scope: ObjectScope) {
        self.scope = scope
    }

    func assemble(container: Container) {
        container.register(Customer.self) { _ in Customer() }.inObjectScope(scope)

        container.register(Employee.self) {
            Employee(
                customer: $0.resolve(Customer.self)!,
                lazyCustomer: $0.resolve(Lazy<Customer>.self)!
            )
        }.initCompleted {
            if self.scope !== ObjectScope.transient {
                $1.employer = $0.resolve(Employer.self)
            }
        }.inObjectScope(scope)

        container.register(Employer.self) {
            Employer(
                customer: $0.resolve(Customer.self)!,
                lazyCustomer: $0.resolve(Lazy<Customer>.self)!,
                employee: $0.resolve(Employee.self)!,
                lazyEmployee: $0.resolve(Lazy<Employee>.self)!
            )
        }.inObjectScope(scope)
    }
}
