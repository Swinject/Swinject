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
        availableRegistrations: [ServiceKey: ServiceEntryType]
    )
}

internal final class LoggingDebugHelper: DebugHelper {

    func resolutionFailed<Service>(
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryType]
    ){

    }
}
