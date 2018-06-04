//
//  DebugHelper.swift
//  Swinject
//
//  Created by Jakub Vaňo on 26/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

internal protocol DebugHelper {
    func resolutionFailed<Service>(
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryProtocol]
    )
}

internal final class LoggingDebugHelper: DebugHelper {

    func resolutionFailed<Service>(
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryProtocol]
    ) {
        var output = [
            "Swinject: Resolution failed. Expected registration:",
            "\t{ \(description(serviceType: serviceType, serviceKey: key)) }",
            "Available registrations:"
        ]
        output += availableRegistrations
            .filter { $0.1 is ServiceEntry<Service> }
            .map { "\t{ " + $0.1.describeWithKey($0.0) + " }" }

        Container.log(output.joined(separator: "\n"))
    }
}

internal func description(
    serviceType: Any.Type,
    serviceKey: ServiceKey,
    objectScope: ObjectScopeProtocol? = nil,
    initCompleted: [Any] = []
) -> String {
    // The protocol order in "protocol<>" is non-deterministic.
    let nameDescription = serviceKey.name.map { ", Name: \"\($0)\"" } ?? ""
    let optionDescription = serviceKey.option.map { ", \($0)" } ?? ""
    let initCompletedDescription = initCompleted.isEmpty ?
        "" : ", InitCompleted: Specified \(initCompleted.count) closures"
    let objectScopeDescription = objectScope.map { ", ObjectScope: \($0)" } ?? ""
    return "Service: \(serviceType)"
        + nameDescription
        + optionDescription
        + ", Factory: \(serviceKey.argumentsType) -> \(serviceKey.serviceType)"
        + objectScopeDescription
        + initCompletedDescription
}
