//
//  UIViewController+Swinject.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import UIKit
import ObjectiveC

private var associationKey: String = "swinjectRegistrationName"

extension UIViewController {
    public var swinjectRegistrationName: String? {
        get {
            return objc_getAssociatedObject(self, &associationKey) as? String
        }
        set {
            objc_setAssociatedObject(self,
                &associationKey,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
}
