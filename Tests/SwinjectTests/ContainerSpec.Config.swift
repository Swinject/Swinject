//
//  ContainerSpec.Config.swift
//  Swinject-iOS
//
//  Created by Oliver Siedler on 06.07.19.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_Config: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("Resolution of a Config file") {
            it("Register not existing file") {
                let notExistingUrl = URL(fileURLWithPath: "Not/A/Path/NotAFile.NotAExt")

                print(NSStringFromClass(Car.self))
                
                expect { try container.registerConfig(notExistingUrl) }.to(throwError())
            }
            it("Resolve configured type") {
                do {
                    let url = Bundle(for: type(of: self)).url(forResource: "Config", withExtension: "json")

                    try container.registerConfig(url!)

                    let car = container.resolveConfig(Car.self, "Car")!
                    expect(car.driver.test) == "Driver"
                } catch {
                    fail("Resolving of type failed (registered through json-config)")
                }
            }
            it("Resolve multiple types") {
                do {
                    let url = Bundle(for: type(of: self)).url(forResource: "Config", withExtension: "json")

                    try container.registerConfig(url!)

                    let car = container.resolveConfig(Car.self, "Car")!
                    expect(car.driver.test) == "Driver"

                    let driver = container.resolveConfig(Driver.self, "Driver")!
                    expect(driver.test) == "Driver"

                    expect(car.driver).toNot(equal(driver))
                } catch {
                    fail("Container failed")
                }
            }
            it("Resolve not existing id") {
                do {
                    let url = Bundle(for: type(of: self)).url(forResource: "Config", withExtension: "json")

                    try container.registerConfig(url!)

                    let car = container.resolveConfig(Car.self, "Car2")

                    expect(car).to(beNil())
                } catch {
                    fail("Container failed")
                }
            }
            it("Register erroneous json (Undefined ID)") {
                let url = Bundle(for: type(of: self)).url(forResource: "ErroneousConfig1", withExtension: "json")

                expect { try container.registerConfig(url!) }.to(throwError())
            }
            it("Register erroneous json (Unique ID Constraint)") {
                let url = Bundle(for: type(of: self)).url(forResource: "ErroneousConfig2", withExtension: "json")

                expect { try container.registerConfig(url!) }.to(throwError())
            }
            it("Register erroneous json (Undefined Setter)") {
                let url = Bundle(for: type(of: self)).url(forResource: "ErroneousConfig3", withExtension: "json")

                expect { try container.registerConfig(url!) }.to(throwError())
            }
        }
    }
}
