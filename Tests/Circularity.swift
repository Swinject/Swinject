//
//  Circularity.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/28/15.
//  Copyright (c) 2015 Swinject Contributors. All rights reserved.
//

import Foundation

// MARK: Circular dependency of two objects
internal protocol ParentType: AnyObject {}
internal protocol ChildType: AnyObject {}

internal class Parent: ParentType {
    internal static var numberOfInstances: Int = 0
    
    var child: ChildType?
    
    init() {
        Parent.numberOfInstances += 1
    }
    
    init(child: ChildType) {
        self.child = child
        Parent.numberOfInstances += 1
    }
}

internal class Child: ChildType {
    internal static var numberOfInstances: Int = 0
    
    weak var parent: ParentType?
    
    init() {
        Child.numberOfInstances += 1
    }
}

// MARK: - Circular dependency of more than two objects
internal protocol AType: AnyObject { }
internal protocol BType: AnyObject { }
internal protocol CType: AnyObject { }
internal protocol DType: AnyObject { }

internal class ADependingOnB: AType {
    var b: BType?
    
    init() {
    }
    
    init(b: BType) {
        self.b = b
    }
}

internal class BDependingOnC: BType {
    var c: CType?
    
    init() {
    }
    
    init(c: CType) {
        self.c = c
    }
}

internal class CDependingOnAD: CType {
    weak var a: AType?
    var d: DType?
    
    init() {
    }
    
    init(d: DType) {
        self.d = d
    }
}

internal class DDependingOnBC: DType {
    weak var b: BType?
    weak var c: CType?
}

// MARK: -Circular dependency with an otuside Player X -> Y <-> Z

internal protocol FType: AnyObject {}
internal protocol GType: AnyObject {
    var h: HType? {get set}
    func foo() -> Bool
}
internal protocol HType: AnyObject {}

internal class FDependindOnG: FType {
    var gFooWasSuccessful: Bool = false
    
    init(g: GType) {
        self.gFooWasSuccessful = g.foo()
    }
}

internal class GDependingOnH: GType {
    var h: HType?
    
    internal func foo() -> Bool {
        return h != nil
    }
}

internal class HDependingOnG: HType {
    var g: GType
    init(g: GType) {
        self.g = g
    }
}
