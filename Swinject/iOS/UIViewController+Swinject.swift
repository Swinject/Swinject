//
//  UIViewController+Swinject.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import UIKit

private var associationKey: String = "UIViewController.swinjectRegistrationName"

extension UIViewController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get {
            return getAssociatedString(key: &associationKey)
        }
        set {
            setAssociatedString(newValue, key: &associationKey)
        }
    }
}
