//
//  PropertyLoaderError.swift
//  Swinject
//
//  Created by mike.owens on 12/8/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// Represents errors that can be thrown when loading properties into a container
///
/// - InvalidJSONFormat:         The JSON format of the properties file is incorrect. Must be top-level dictionary
/// - InvalidPlistFormat:        The Plist format of the properties file is incorrect. Must be top-level dictionary
/// - MissingResource:           The resource is missing from the bundle
/// - InvalidResourceDataFormat: The resource cannot be converted to NSData
///
public enum PropertyLoaderError: ErrorType {
    case InvalidJSONFormat(bundle: NSBundle, name: String)
    case InvalidPlistFormat(bundle: NSBundle, name: String)
    case MissingResource(bundle: NSBundle, name: String)
    case InvalidResourceDataFormat(bundle: NSBundle, name: String)
}

// MARK: - CustomStringConvertible
extension PropertyLoaderError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .InvalidJSONFormat(let bundle, let name):
            return "Invalid JSON format for bundle: \(bundle), name: \(name). Must be top-level dictionary"
        case .InvalidPlistFormat(let bundle, let name):
            return "Invalid Plist format for bundle: \(bundle), name: \(name). Must be top-level dictionary"
        case .MissingResource(let bundle, let name):
            return "Missing resource for bundle: \(bundle), name: \(name)"
        case .InvalidResourceDataFormat(let bundle, let name):
            return "Invalid resource format for bundle: \(bundle), name: \(name)"
        }
    }
}
