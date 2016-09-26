//
//  DependencyAnalyzer.swift
//  Swinject
//
//  Created by Markus Riegel on 25.09.16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Foundation

public final class DependencyAnalyzer: Resolvable {
    
    internal var dependencies = Set<ServiceType>()
    
    public init() {}
    
    public func resolve<Service>(
        serviceType: Service.Type) -> Service?
    {
        return resolve(serviceType, name: nil)
    }
    
    public func resolve<Service>(
        serviceType: Service.Type,
        name: String?) -> Service?
    {
        typealias FactoryType = ResolverType -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self) }
    }
    
    internal func resolveImpl<Service, Factory>(name: String?, invoker: Factory -> Service) -> Service? {
        let serviceType = Service.self
        let serviceTypeWrapper = ServiceType(serviceType: serviceType)
        dependencies.insert(serviceTypeWrapper)
        return nil
    }
}

extension DependencyAnalyzer: PropertyRetrievable {
    public func property<Property>(name: String) -> Property? {
        return nil
    }
}

internal struct ServiceType: Hashable {
    let serviceType: Any.Type
    
    init(serviceType: Any.Type) {
        self.serviceType = serviceType
    }
    
    var hashValue: Int {
        return String(serviceType).hashValue
    }
}

func ==(lhs: ServiceType, rhs: ServiceType) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
