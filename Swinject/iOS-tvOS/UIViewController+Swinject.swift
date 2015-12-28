//
//  ViewController+Swinject.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(tvOS)

private var uivcAssociationKey: String = "UIViewController.swinjectRegistrationName"

extension UIViewController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get {
            return getAssociatedString(key: &uivcAssociationKey)
        }
        set {
            setAssociatedString(newValue, key: &uivcAssociationKey)
        }
    }
}

#elseif os(OSX)

private var nsvcAssociationKey: String = "NSViewController.swinjectRegistrationName"
private var nswcAssociationKey: String = "NSWindowController.swinjectRegistrationName"

extension NSViewController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get {
            return getAssociatedString(key: &nsvcAssociationKey)
        }
        set {
            setAssociatedString(newValue, key: &nsvcAssociationKey)
        }
    }
}

extension NSWindowController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get {
            return getAssociatedString(key: &nswcAssociationKey)
        }
        set {
            setAssociatedString(newValue, key: &nswcAssociationKey)
        }
    }
}

#endif
