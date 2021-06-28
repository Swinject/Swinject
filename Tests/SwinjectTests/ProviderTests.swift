//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ProviderTests: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Instance production

    func testProviderProvidesInstanceFromContainer() {
        container.register(Animal.self) { _ in Dog() }
        let provider = container.resolve(Provider<Animal>.self)
        XCTAssert(provider?.instance is Dog)
    }

    func testProviderDoesNotCreateInstanceUntilRequested() {
        var created = false
        container.register(Animal.self) { _ in created = true; return Dog() }

        _ = container.resolve(Provider<Animal>.self)

        XCTAssertFalse(created)
    }

    func testProviderResolveInstanceFromContainerEachTime() {
        var created = 0
        container.register(Animal.self) { _ in created += 1; return Dog() }

        let provider = container.resolve(Provider<Animal>.self)
        _ = provider?.instance
        _ = provider?.instance

        XCTAssertEqual(created, 2)
    }

    func testProviderDoesNotResolveProviderIfBaseTypeIsNotRegistered() {
        let provider = container.resolve(Provider<Animal>.self)
        XCTAssertNil(provider)
    }

    // MARK: Object scopes

    func testContainerAlwaysProducesDifferentIncetanceInTransientScope() {
        EmploymentAssembly(scope: .transient).assemble(container: container)
        let employer = container.resolve(Employer.self)!
        XCTAssert(employer.providedEmployee.instance !== employer.providedEmployee.instance)
        XCTAssert(employer.employee.providedCustomer.instance !== employer.providedCustomer.instance)
    }

    func testContainerAlwaysProducesDifferentIncetanceInGraphScope() {
        EmploymentAssembly(scope: .graph).assemble(container: container)
        let employer = container.resolve(Employer.self)!
        XCTAssert(employer.providedEmployee.instance !== employer.providedEmployee.instance)
        XCTAssert(employer.employee.providedCustomer.instance !== employer.providedCustomer.instance)
    }

    func testContainerAlwaysProducesSameIncetanceInContainerScope() {
        EmploymentAssembly(scope: .container).assemble(container: container)
        let employer = container.resolve(Employer.self)!
        XCTAssert(employer.providedEmployee.instance === employer.providedEmployee.instance)
        XCTAssert(employer.employee.providedCustomer.instance === employer.providedCustomer.instance)
    }

    // MARK: Complex registrations

    func testContainerResolvesProviderrWithArguments() {
        container.register(Dog.self) { (_, name, _: Int) in Dog(name: name) }
        let provider = container.resolve(Provider<Dog>.self, arguments: "Hachi", 42)
        XCTAssertEqual(provider?.instance.name, "Hachi")
    }

    func testContainerResolvesProviderWithName() {
        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        let provider = container.resolve(Provider<Dog>.self, name: "Hachi")
        XCTAssertNotNil(provider)
    }

    func testContainerDoesNotResolveProoviderWithWrongName() {
        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        let provider = container.resolve(Provider<Dog>.self, name: "Mimi")
        XCTAssertNil(provider)
    }

    func testContainerResolveForwarrdedProviderType() {
        container.register(Dog.self) { _ in Dog() }.implements(Animal.self)
        let provider = container.resolve(Provider<Animal>.self)
        XCTAssertNotNil(provider)
    }

    // MARK: Circular dependencies

    func testContainerResolvesNonProovidedDependenciesToTheSameInstance() {
        EmploymentAssembly(scope: .graph).assemble(container: container)
        let employer = container.resolve(Provider<Employer>.self)?.instance
        XCTAssert(employer?.employee.employer === employer)
    }

    func testContainerResolvesProvidedDependenciesToDifferentInstances() {
        EmploymentAssembly(scope: .graph).assemble(container: container)
        let employer = container.resolve(Employer.self)
        XCTAssert(employer?.providedEmployee.instance.employer !== employer)
    }
}
