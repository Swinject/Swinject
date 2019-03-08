//
//  Container.Logging.swift
//  Swinject
//
//  Created by Jakub Vaňo on 30/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

public typealias LoggingFunctionType = (String) -> Void

public extension Container {
    /// Function to be used for logging debugging data.
    /// Default implementation writes to standard output.
    static var loggingFunction: LoggingFunctionType? {
        get { return _loggingFunction }
        set { _loggingFunction = newValue }
    }

    internal static func log(_ message: String) {
        _loggingFunction?(message)
    }
}

private var _loggingFunction: LoggingFunctionType? = { print($0) }
