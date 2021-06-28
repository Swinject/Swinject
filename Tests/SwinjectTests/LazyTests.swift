//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
import Swinject

class LazyTests: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Instance production

    func testContainerProvidesInstanceFromContainer() {
        container.register(Animal.self) { _ in Dog() }
        let lazy = container.resolve(Lazy<Animal>.self)
        XCTAssert(lazy?.instance is Dog)
    }

    func testContainerDoesNotCreateInstanceUntilRequested() {
        var created = false
        container.register(Animal.self) { _ in created = true; return Dog() }

        _ = container.resolve(Lazy<Animal>.self)

        XCTAssertFalse(created)
    }

    func testContainerResolveInstanceFromContainerOnlyOnce() {
        var created = 0
        container.register(Animal.self) { _ in created += 1; return Dog() }

        let lazy = container.resolve(Lazy<Animal>.self)
        _ = lazy?.instance
        _ = lazy?.instance

        XCTAssertEqual(created, 1)
    }

    func testContainerDoesNotResolveLazyIfBaseTypeIsNotRegistered() {
        let lazy = container.resolve(Lazy<Animal>.self)
        XCTAssertNil(lazy)
    }

    // MARK: Object scopes

    func testContainerAlwaysProducesDifferentInstanceForRelatedObjectsInTransientScope() {
        EmploymentAssembly(scope: .transient).assemble(container: container)
        let employer = container.resolve(Employer.self)!
        XCTAssert(employer.lazyCustomer.instance !== employer.employee.lazyCustomer.instance)
        XCTAssert(employer.lazyCustomer.instance !== employer.customer)
    }

    func testContainerAlwaysProducesTheSameInstanceForRelatedObjectsInContainerScope() {
        EmploymentAssembly(scope: .container).assemble(container: container)
        let employer = container.resolve(Employer.self)!
        XCTAssert(employer.lazyCustomer.instance === employer.employee.lazyCustomer.instance)
        XCTAssert(employer.lazyCustomer.instance === employer.customer)
    }

    func testContainerAlwaysProducesTheSameInstanceForRelatedObjectsInGraphScope() {
        EmploymentAssembly(scope: .graph).assemble(container: container)
        let employer = container.resolve(Employer.self)!
        XCTAssert(employer.lazyCustomer.instance === employer.employee.lazyCustomer.instance)
        XCTAssert(employer.lazyCustomer.instance === employer.customer)
    }

    // MARK: Complex registrations

    func testContainerResolvesLazyWithArguments() {
        container.register(Dog.self) { (_, name, _: Int) in Dog(name: name) }
        let lazy = container.resolve(Lazy<Dog>.self, arguments: "Hachi", 42)
        XCTAssertEqual(lazy?.instance.name, "Hachi")
    }

    func testContainerResolvesLazyWithName() {
        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        let lazy = container.resolve(Lazy<Dog>.self, name: "Hachi")
        XCTAssertNotNil(lazy)
    }

    func testContainerDoesNotResolveLazyWithWrongName() {
        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        let lazy = container.resolve(Lazy<Dog>.self, name: "Mimi")
        XCTAssertNil(lazy)
    }

    func testContainerDoesResolveForwardedLazyType() {
        container.register(Dog.self) { _ in Dog() }.implements(Animal.self)
        let lazy = container.resolve(Lazy<Animal>.self)
        XCTAssertNotNil(lazy)
    }

    // MARK: Circular dependencies

    func testContainerResolvesDependenciesToSameInstance() {
        EmploymentAssembly(scope: .graph).assemble(container: container)
        let employer = container.resolve(Employer.self)
        XCTAssert(employer?.employee.employer === employer)
        XCTAssert(employer?.lazyEmployee.instance.employer === employer)
    }

    func testContainerResolvesCircularDependenciesForLazyInstance() {
        EmploymentAssembly(scope: .graph).assemble(container: container)
        let employee = container.resolve(Lazy<Employee>.self)
        XCTAssertNotNil(employee?.instance.employer)
    }
}
