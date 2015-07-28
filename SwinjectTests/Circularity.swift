//
//  Circularity.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/28/15.
//  Copyright (c) 2015 DevSwinject. All rights reserved.
//

import Foundation

internal protocol ParentType: AnyObject { }
internal protocol ChildType: AnyObject { }

internal class Mother: ParentType {
    weak var child: ChildType?
}

internal class Daughter: ChildType {
    var parent: ParentType?
    
    init() {
    }
    
    init(parent: ParentType) {
        self.parent = parent
    }
}
