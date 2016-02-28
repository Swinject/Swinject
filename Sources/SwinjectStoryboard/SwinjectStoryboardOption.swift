//
//  SwinjectStoryboardOption.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 2/28/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(OSX) || os(tvOS)
internal struct SwinjectStoryboardOption: ServiceKeyOptionType {
    internal let controllerType: String
    
    internal init(controllerType: Container.Controller.Type) {
        self.controllerType = String(reflecting: controllerType)
    }
    
    internal func isEqualTo(another: ServiceKeyOptionType) -> Bool {
        guard let another = another as? SwinjectStoryboardOption else {
            return false
        }
        
        return self.controllerType == another.controllerType
    }
    
    internal var hashValue: Int {
        return controllerType.hashValue
    }
}
#endif
