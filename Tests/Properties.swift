//
//  Properties.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//


/// Simple class to test property resolution
class Properties {
    var stringValue: String = ""
    var intValue: Int = 0
    var doubleValue: Double = 0.0
    var arrayValue: [String] = []
    var dictValue: [String:String] = [:]
    var boolValue: Bool = false
    
    var optionalStringValue: String?
    var optionalIntValue: Int?
    var optionalDoubleValue: Double?
    var optionalArrayValue: [String]?
    var optionalDictValue: [String:String]?
    var optionalBoolValue: Bool?
    
    var implicitStringValue: String!
    var implicitIntValue: Int!
    var implicitDoubleValue: Double!
    var implicitArrayValue: [String]!
    var implicitDictValue: [String:String]!
    var implicitBoolValue: Bool!
}
