//
//  NSWindowController+Swinject.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import AppKit
import ObjectiveC

private var associationKey: String = "NSWindowController.swinjectRegistrationName"

extension NSWindowController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get {
            return objc_getAssociatedObject(self, &associationKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &associationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_COPY))
        }
    }
}
