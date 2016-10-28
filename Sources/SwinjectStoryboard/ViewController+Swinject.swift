//
//  ViewController+Swinject.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import ObjectiveC

#if os(iOS) || os(tvOS)

private var uivcRegistrationNameKey: String = "UIViewController.swinjectRegistrationName"
private var uivcWasInjectedKey: String = "UIViewController.wasInjected"

extension UIViewController: RegistrationNameAssociatable {
    internal var swinjectRegistrationName: String? {
        get { return getAssociatedString(key: &uivcRegistrationNameKey) }
        set { setAssociatedString(newValue, key: &uivcRegistrationNameKey) }
    }

    internal var wasInjected: Bool {
        get { return getAssociatedBool(key: &uivcWasInjectedKey) ?? false }
        set { setAssociatedBool(newValue, key: &uivcWasInjectedKey) }
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

extension NSObject {
    private func getAssociatedString(key key: UnsafePointer<Void>) -> String? {
        return objc_getAssociatedObject(self, key) as? String
    }

    private func setAssociatedString(string: String?, key: UnsafePointer<Void>) {
        objc_setAssociatedObject(self, key, string, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }

    private func getAssociatedBool(key key: UnsafePointer<Void>) -> Bool? {
        return (objc_getAssociatedObject(self, key) as? NSNumber)?.boolValue
    }

    private func setAssociatedBool(bool: Bool, key: UnsafePointer<Void>) {
        objc_setAssociatedObject(self, key, NSNumber(bool: bool), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
}
