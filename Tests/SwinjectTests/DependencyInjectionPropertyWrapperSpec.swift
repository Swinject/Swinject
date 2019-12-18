//
//  DependencyInjectionPropertyWrapperSpec.swift
//  Swinject-iOS
//
//  Created by Tyler Thompson on 12/17/19.
//

import Foundation
import Nimble
import Quick

import Swinject

class DependencyInjectionPropertyWrapperSpec: QuickSpec {
    static var container = Container()
    override func setUp() {
        DependencyInjectionPropertyWrapperSpec.container = Container()
    }
    override func spec() {
        describe("Property Wrapper") {
            it("should resolve a dependency from a container") {
                DependencyInjectionPropertyWrapperSpec.container.register(Animal.self) { _ in Cat(name: "test") }
                class Thing {
                    @DependencyInjected(container: DependencyInjectionPropertyWrapperSpec.container) var animal:Animal?
                }
                
                expect(Thing().animal?.name) == "test"
            }
            
            it("should resolve a dependency with a name") {
                DependencyInjectionPropertyWrapperSpec.container.register(Animal.self, name: "first") { _ in Cat(name:"1") }
                DependencyInjectionPropertyWrapperSpec.container.register(Animal.self, name: "second") { _ in Cat(name:"2") }
                class Thing {
                    @DependencyInjected(container: DependencyInjectionPropertyWrapperSpec.container, name: "second") var animal:Animal?
                }
                
                expect(Thing().animal?.name) == "2"
            }
            
            it("should be trivial to extend with a shared container") {
                Container.shared.register(Animal.self) { _ in Cat(name:"1") }
                class Thing {
                    //NOTE: If we were to have a shared container packaged with Swinject the = nil part of this would be unecessary
                    @DependencyInjected var animal:Animal? = nil
                }
                
                expect(Thing().animal?.name) == "1"
            }

        }
    }
}

fileprivate extension Container {
    static var shared = Container()
}

fileprivate extension DependencyInjected {
    init(wrappedValue:Value? = nil) {
        self.init(wrappedValue: wrappedValue, container: Container.shared)
    }
}
