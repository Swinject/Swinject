//
//  ContainerSpec.Arguments.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/3/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_Arguments: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }
        
        it("accepts 1 argument.") {
            container.register(AnimalType.self) { _, arg1 in
                Cat(name: arg1)
            }
            let animal = container.resolve(
                AnimalType.self,
                argument: "1")!
            expect(animal.name) == "1"
        }
        it("accepts 2 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2 in
                Cat(name: arg1 + arg2)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2"))!
            expect(animal.name) == "12"
        }
        it("accepts 3 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3 in
                Cat(name: arg1 + arg2 + arg3)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3"))!
            expect(animal.name) == "123"
        }
        it("accepts 4 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3, arg4 in
                Cat(name: arg1 + arg2 + arg3 + arg4)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3", "4"))!
            expect(animal.name) == "1234"
        }
        it("accepts 5 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3, arg4, arg5 in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3", "4", "5"))!
            expect(animal.name) == "12345"
        }
        it("accepts 6 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3, arg4, arg5, arg6 in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3", "4", "5", "6"))!
            expect(animal.name) == "123456"
        }
        it("accepts 7 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7 in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3", "4", "5", "6", "7"))!
            expect(animal.name) == "1234567"
        }
        it("accepts 8 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3", "4", "5", "6", "7", "8"))!
            expect(animal.name) == "12345678"
        }
        it("accepts 9 arguments.") {
            container.register(AnimalType.self) { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 in
                Cat(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9)
            }
            let animal = container.resolve(
                AnimalType.self,
                arguments: ("1", "2", "3", "4", "5", "6", "7", "8", "9"))!
            expect(animal.name) == "123456789"
        }
    }
}
