//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation
public typealias LoggingFunctionType = (String) -> Void

public extension Container {
    /// Function to be used for logging debugging data.
    /// Default implementation writes to standard output.
    @MainActor static var loggingFunction: LoggingFunctionType? {
        get { return _loggingFunction }
        set { _loggingFunction = newValue }
    }

    @MainActor internal static func log(_ message: String) {
        _loggingFunction?(message)
    }
}

@MainActor private var _loggingFunction: LoggingFunctionType? = {
    if ProcessInfo.processInfo.environment["SWINJECT_LOGGING_ENABLED"] == "1" {
        print($0)
    }
}
