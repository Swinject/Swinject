//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_Arguments: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    func testContainierAccepts1Argument() {
        container.register(Animal.self) { _, arg1 in
            Cat(name: arg1)
        }
        let animal = container.resolve(
            Animal.self,
            argument: "1"
        )
        XCTAssertEqual(animal?.name, "1")
    }

    func testContainierAccepts2Arguments() {
        container.register(Animal.self) { _, arg1, arg2 in
            Cat(name: arg1 + arg2)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2"
        )
        XCTAssertEqual(animal?.name, "12")
    }

    func testContainierAccepts3Arguments() {
        container.register(Animal.self) { _, arg1, arg2, arg3 in
            Cat(name: arg1 + arg2 + arg3)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3"
        )
        XCTAssertEqual(animal?.name, "123")
    }

    func testContainierAccepts4Arguments() {
        container.register(Animal.self) { _, arg1, arg2, arg3, arg4 in
            Cat(name: arg1 + arg2 + arg3 + arg4)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3", "4"
        )
        XCTAssertEqual(animal?.name, "1234")
    }

    func testContainierAccepts5Arguments() {
        container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String) in // swiftlint:disable:this line_length
            Cat(name: arg1 + arg2 + arg3 + arg4 + arg5)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3", "4", "5"
        )
        XCTAssertEqual(animal?.name, "12345")
    }

    func testContainierAccepts6Arguments() {
        container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String) in // swiftlint:disable:this line_length
            Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3", "4", "5", "6"
        )
        XCTAssertEqual(animal?.name, "123456")
    }

    func testContainierAccepts7Arguments() {
        container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String, arg7: String) in // swiftlint:disable:this line_length
            Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3", "4", "5", "6", "7"
        )
        XCTAssertEqual(animal?.name, "1234567")
    }

    func testContainierAccepts8Arguments() {
        container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String, arg7: String, arg8: String) in // swiftlint:disable:this line_length
            Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3", "4", "5", "6", "7", "8"
        )
        XCTAssertEqual(animal?.name, "12345678")
    }

    func testContainierAccepts9Arguments() {
        container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String, arg7: String, arg8: String, arg9: String) in // swiftlint:disable:this line_length
            Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9)
        }
        let animal = container.resolve(
            Animal.self,
            arguments: "1", "2", "3", "4", "5", "6", "7", "8", "9"
        )
        XCTAssertEqual(animal?.name, "123456789")
    }
}
