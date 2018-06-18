//
//  ContainerSpec.Arguments.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/3/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//
// swiftlint:disable function_body_length line_length

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_ShortStyle: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }
        
        it("accepts 0 argument.") {
            container.register(Animal.self) { _ in
                Cat(name: "No args")
            }
            let animal: Animal? = container.resolve()
            expect(animal?.name) == "No args"
        }
        it("accepts 1 argument.") {
            container.register(Animal.self) { _, arg1 in
                Cat(name: arg1)
            }
            let animal: Animal? = container.resolve(
                argument: "1")
            expect(animal?.name) == "1"
        }
        it("accepts 2 arguments.") {
            container.register(Animal.self) { _, arg1, arg2 in
                Cat(name: arg1 + arg2)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2")
            expect(animal?.name) == "12"
        }
        it("accepts 3 arguments.") {
            container.register(Animal.self) { _, arg1, arg2, arg3 in
                Cat(name: arg1 + arg2 + arg3)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3")
            expect(animal?.name) == "123"
        }
        it("accepts 4 arguments.") {
            container.register(Animal.self) { _, arg1, arg2, arg3, arg4 in
                Cat(name: arg1 + arg2 + arg3 + arg4)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3", "4")
            expect(animal?.name) == "1234"
        }
        it("accepts 5 arguments.") {
            container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String) in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3", "4", "5")
            expect(animal?.name) == "12345"
        }
        it("accepts 6 arguments.") {
            container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String) in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3", "4", "5", "6")
            expect(animal?.name) == "123456"
        }
        it("accepts 7 arguments.") {
            container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String, arg7: String) in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3", "4", "5", "6", "7")
            expect(animal?.name) == "1234567"
        }
        it("accepts 8 arguments.") {
            container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String, arg7: String, arg8: String) in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3", "4", "5", "6", "7", "8")
            expect(animal?.name) == "12345678"
        }
        it("accepts 9 arguments.") {
            container.register(Animal.self) { (_, arg1: String, arg2: String, arg3: String, arg4: String, arg5: String, arg6: String, arg7: String, arg8: String, arg9: String) in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9)
            }
            let animal: Animal? = container.resolve(
                arguments: "1", "2", "3", "4", "5", "6", "7", "8", "9")
            expect(animal?.name) == "123456789"
        }
    }
}
