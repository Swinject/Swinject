//
//  PropertyRetrievable.swift
//  Swinject
//
//  Created by mike.owens on 12/7/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//


public protocol PropertyRetrievable {
    
    /// Retrieves a property for the given name where the receiving property is optional. This is a limitation of
    /// how you can reflect a Optional<Foo> class type where you cannot determine the inner type is Foo without parsing
    /// the string description (yuck). So in order to inject into an optioanl property, you need to specify the type
    /// so we can properly cast the object
    ///
    /// - Parameter key: The name for the property
    /// - Parameter type: The type of the property
    ///
    /// - Returns: The value for the property name
    func property<Property>(name: String) -> Property?
}
