//
//  Definition.swift
//  Swinject
//
//  Created by Иван Ушаков on 11.10.15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

public class Definition<Service>
{
    typealias FactoryType = Resolvable -> Service
    typealias ComplitedType = (Resolvable, Service) -> Void
    
    internal let serviceType: Service.Type
    internal var initializer: FactoryType?;
    internal var complited: ComplitedType?;
    var scope: ObjectScope = ObjectScope.Graph;
    
    init(_ serviceType: Service.Type) {
        self.serviceType = serviceType
    }
    
    public func initialize(initializer:(Resolvable -> Service)) {
        self.initializer = initializer
    }
    
    public func complite(complited: (Resolvable, Service) -> Void) {
        self.complited = complited
    }
}