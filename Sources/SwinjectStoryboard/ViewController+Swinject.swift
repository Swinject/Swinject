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

extension UIViewController: RegistrationNameAssociatable, InjectionVerifiable {
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

private var nsvcRegistrationNameKey: String = "NSViewController.swinjectRegistrationName"
private var nswcRegistrationNameKey: String = "NSWindowController.swinjectRegistrationName"
private var nsvcWasInjectedKey: String = "NSViewController.wasInjected"
private var nswcWasInjectedKey: String = "NSWindowController.wasInjected"

extension NSViewController: RegistrationNameAssociatable, InjectionVerifiable {
    internal var swinjectRegistrationName: String? {
        get { return getAssociatedString(key: &nsvcRegistrationNameKey) }
        set { setAssociatedString(newValue, key: &nsvcRegistrationNameKey) }
    }

    internal var wasInjected: Bool {
        get { return getAssociatedBool(key: &nsvcWasInjectedKey) ?? false }
        set { setAssociatedBool(newValue, key: &nsvcWasInjectedKey) }
    }
}

extension NSWindowController: RegistrationNameAssociatable, InjectionVerifiable {
    internal var swinjectRegistrationName: String? {
        get { return getAssociatedString(key: &nsvcRegistrationNameKey) }
        set { setAssociatedString(newValue, key: &nsvcRegistrationNameKey) }
    }

    internal var wasInjected: Bool {
        get { return getAssociatedBool(key: &nswcWasInjectedKey) ?? false }
        set { setAssociatedBool(newValue, key: &nswcWasInjectedKey) }
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
