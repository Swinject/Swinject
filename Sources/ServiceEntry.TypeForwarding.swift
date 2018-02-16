//
//  ServiceEntry.TypeForwarding.swift
//  Swinject-iOS
//
//  Created by Jakub Vaňo on 16/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// ServiceEntry.TypeForwarding.swift is generated from ServiceEntry.TypeForwarding.erb by ERB.
// Do NOT modify ServiceEntry.TypeForwarding.swift directly.
// Instead, modify ServiceEntry.TypeForwarding.erb and run `script/gencode` at the project root directory to generate the code.
//


extension ServiceEntry {
    @discardableResult
    public func implements<T>(_ type: T.Type, name: String? = nil) -> ServiceEntry<Service> {
        container?.forward(type, name: name, to: self)
        return self
    }

    @discardableResult
    public func implements<T1, T2>(_ type1: T1.Type, _ type2: T2.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3, T4>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type, _ type4: T4.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3).implements(type4)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3, T4, T5>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type, _ type4: T4.Type, _ type5: T5.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3).implements(type4).implements(type5)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3, T4, T5, T6>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type, _ type4: T4.Type, _ type5: T5.Type, _ type6: T6.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3).implements(type4).implements(type5).implements(type6)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3, T4, T5, T6, T7>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type, _ type4: T4.Type, _ type5: T5.Type, _ type6: T6.Type, _ type7: T7.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3).implements(type4).implements(type5).implements(type6).implements(type7)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3, T4, T5, T6, T7, T8>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type, _ type4: T4.Type, _ type5: T5.Type, _ type6: T6.Type, _ type7: T7.Type, _ type8: T8.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3).implements(type4).implements(type5).implements(type6).implements(type7).implements(type8)        
    }
    
    @discardableResult
    public func implements<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ type1: T1.Type, _ type2: T2.Type, _ type3: T3.Type, _ type4: T4.Type, _ type5: T5.Type, _ type6: T6.Type, _ type7: T7.Type, _ type8: T8.Type, _ type9: T9.Type) -> ServiceEntry<Service> {
        return self.implements(type1).implements(type2).implements(type3).implements(type4).implements(type5).implements(type6).implements(type7).implements(type8).implements(type9)        
    }
    
}
