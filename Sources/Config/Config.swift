//
//  Config.swift
//  Swinject-iOS
//
//  Created by Oliver Siedler on 06.07.19.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The Config Struct defines the Format of the Json-Config-File
/// It Contains an array of Definitions, which each define one Service
class Config: Codable {
    var definitions: [Definition]
    
    /// Checks wether the Config is valide or not
    /// - Returns: True if the Config is valid, else returns false
    public func validate() -> Bool {
        //Check if Ids are uniqe
        for definition in definitions {
            let contains = definitions.contains { (def) -> Bool in
                if def.identifier == definition.identifier && def !== definition {
                    print("Used Id is not Unique\nId: " + def.identifier)
                    return true
                }
                
                return false
            }
            if contains {
                return false
            }
        }

        //Check if all used arguments exist
        for definition in definitions {
            for arg in definition.arguments {
                if arg.identifier == definition.identifier {
                    print("Cant define a Type using itself as Constructor-Argument\n" +
                            "Type-ID: " + arg.identifier)
                    return false
                }

                let contains = definitions.contains { (def) -> Bool in
                    return def.identifier == arg.identifier
                }

                if !contains {
                    print("Using of undefined Type-Id\n" +
                            "Type-ID: " + arg.identifier)
                    return false
                }
            }
        }

        return true
    }
}

/// A Definition defines a Service with its Constructor arguments
/// The arguments array contains ids of other Services to add in the Constructor
class Definition: Codable {
    var identifier: String
    var type: String
    var arguments: [Argument]
}

/// The Arguments describe Properties to Set after the Construction
/// Value refers to the Property-Nanme, Id to another type as argument
class Argument: Codable {
    var value: String
    var identifier: String

    public func getMethodDescription() -> String {
        return "set" + value.prefix(1).uppercased() + value.dropFirst() + ":"
    }
}
