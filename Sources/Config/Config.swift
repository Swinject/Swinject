//
//  Config.swift
//  Swinject-iOS
//
//  Created by Oliver Siedler on 06.07.19.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The Config Struct defines the Format of the Json-Config-File
/// It Contains an array of Definitions, which each define one Service
struct Config : Codable {
    var definitions: [Definition]
}

/// A Definition defines a Service with its Constructor arguments
/// The arguments array contains ids of other Services to add in the Constructor
struct Definition : Codable {
    var id: String
    var type: String
    var arguments: [Argument]
}

/// The Arguments describe Properties to Set after the Construction
/// Value refers to the Property-Nanme, Id to another type as argument
struct Argument : Codable {
    var value: String
    var id: String
}
