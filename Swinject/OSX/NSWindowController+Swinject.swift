//
//  NSWindowController+Swinject.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import AppKit

private var associationKey: String = "NSWindowController.swinjectRegistrationName"

extension NSWindowController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get {
            return getAssociatedString(key: &associationKey)
        }
        set {
            setAssociatedString(newValue, key: &associationKey)
        }
    }
}
