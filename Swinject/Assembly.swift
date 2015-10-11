//
//  Assembly.swift
//  Swinject
//
//  Created by Иван Ушаков on 11.10.15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

public class Assembly
{
    internal var container: Container
    
    required public init(container: Container)
    {
        self.container = container;
        create()
    }
    
    public func create()
    {
        fatalError("You should implement create method of assembly");
    }
    
    public func register<Service>(
        serviceType: Service.Type,
        name: String? = nil,
        definitionAssembly:(Definition<Service> -> Void)) -> (Void -> Service)
    {
        let definition = Definition<Service>(serviceType)
        definitionAssembly(definition)
        container.register(definition)
        
        return {
            guard let service = self.container.resolve(serviceType) else {
                fatalError("Service \(serviceType) con not be  resloved")
            }
            
            return service
        };
    }
}