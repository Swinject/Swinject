//
//  Container.Logging.swift
//  Swinject
//
//  Created by Jakub Vaňo on 30/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

public typealias LoggingFunctionType = (String) -> Void

public extension Container {
    public static var logingFunction: LoggingFunctionType? {
        get { return _logingFunction }
        set { _logingFunction = newValue }
    }

    internal static func log(_ message: String) {
        _logingFunction?(message)
    }
}

private var _logingFunction: LoggingFunctionType? = { print($0) }
