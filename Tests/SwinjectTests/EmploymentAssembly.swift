//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

class Customer {}

class Employee {
    let customer: Customer
    let lazyCustomer: Lazy<Customer>
    let providedCustomer: Provider<Customer>
    var employer: Employer?

    init(customer: Customer, lazyCustomer: Lazy<Customer>, providedCustomer: Provider<Customer>) {
        self.customer = customer
        self.lazyCustomer = lazyCustomer
        self.providedCustomer = providedCustomer
    }
}

class Employer {
    let customer: Customer
    let lazyCustomer: Lazy<Customer>
    let providedCustomer: Provider<Customer>
    let employee: Employee
    let lazyEmployee: Lazy<Employee>
    let providedEmployee: Provider<Employee>

    init(
        customer: Customer,
        lazyCustomer: Lazy<Customer>,
        providedCustomer: Provider<Customer>,
        employee: Employee,
        lazyEmployee: Lazy<Employee>,
        providedEmployee: Provider<Employee>
    ) {
        self.customer = customer
        self.lazyCustomer = lazyCustomer
        self.providedCustomer = providedCustomer
        self.employee = employee
        self.lazyEmployee = lazyEmployee
        self.providedEmployee = providedEmployee
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
                lazyCustomer: $0.resolve(Lazy<Customer>.self)!,
                providedCustomer: $0.resolve(Provider<Customer>.self)!
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
                providedCustomer: $0.resolve(Provider<Customer>.self)!,
                employee: $0.resolve(Employee.self)!,
                lazyEmployee: $0.resolve(Lazy<Employee>.self)!,
                providedEmployee: $0.resolve(Provider<Employee>.self)!
            )
        }.inObjectScope(scope)
    }
}
