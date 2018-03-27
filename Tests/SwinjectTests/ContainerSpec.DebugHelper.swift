//
//  ContainerSpec.DebugHelper.swift
//  Swinject
//
//  Created by Jakub Vaňo on 26/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec_DebugHelper: QuickSpec {
    override func spec() {
        var spy: DebugHelperSpy!
        beforeEach { spy = DebugHelperSpy() }

        describe("resolution fails") {
            it("should call debug helper with failing service and key") {
                let container = Container(debugHelper: spy)

                _ = container._resolve(name: "name") { (_: (Int) -> Any) in return 1 as Double } as Double?

                expect("\(spy.serviceType)") == "Double"
                expect(spy.key) == ServiceKey(
                    serviceType: Double.self,
                    argumentsType: Int.self,
                    name: "name",
                    option: nil
                )
            }

            it("should call helper with all registrations") {
                let container = Container(debugHelper: spy)
                container.register(Int.self) { _ in 0 }
                container.register(Double.self) { _ in 0}

                _ = container.resolve(String.self)

                expect(spy.availableRegistrations?.count) == 2
            }

            context("has parent container") {
                it("should call helper with parent registrations") {
                    let parent = Container()
                    parent.register(Int.self) { _ in 0 }
                    let container = Container(parent: parent, debugHelper: spy)
                    container.register(Double.self) { _ in 0 }

                    _ = container.resolve(String.self)

                    expect(spy.availableRegistrations?.count) == 2
                }
            }
        }
    }
}

private class DebugHelperSpy: DebugHelper {

    var serviceType: Any = ""
    var key: ServiceKey?
    var availableRegistrations: [ServiceKey: ServiceEntryProtocol]?

    func resolutionFailed<Service>(
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryProtocol]
    ) {
        self.serviceType = serviceType
        self.key = key
        self.availableRegistrations = availableRegistrations
    }
}
