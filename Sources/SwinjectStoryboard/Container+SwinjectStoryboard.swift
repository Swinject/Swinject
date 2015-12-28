//
//  Container+SwinjectStoryboard.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/28/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(OSX) || os(tvOS)
extension Container {
    /// Adds a registration of the specified view or window controller that is configured in a storyboard.
    ///
    /// - Note: Do NOT explicitly resolve the controller registered by this method.
    ///         The controller is intended to be resolved by `SwinjectStoryboard` implicitly.
    ///
    /// - Parameters:
    ///   - controllerType: The controller type to register as a service type.
    ///                     The type is `UIViewController` in iOS, `NSViewController` or `NSWindowController` in OS X.
    ///   - name:           A registration name, which is used to differenciate from other registrations
    ///                     that have the same view or window controller type.
    ///   - initCompleted:  A closure to specifiy how the dependencies of the view or window controller are injected.
    ///                     It is invoked by the `Container` when the view or window controller is instantiated by `SwinjectStoryboard`.
    public func registerForStoryboard<C: Controller>(controllerType: C.Type, name: String? = nil, initCompleted: (ResolverType, C) -> ()) {
        // Xcode 7.1 workaround for Issue #10. This workaround is not necessary with Xcode 7.
        // The actual controller type is distinguished by the dynamic type name in `nameWithActualType`.
        let nameWithActualType = String(reflecting: controllerType) + ":" + (name ?? "")
        let wrappingClosure: (ResolverType, Controller) -> () = { r, c in initCompleted(r, c as! C) }
        self.register(Controller.self, name: nameWithActualType) { (_: ResolverType, controller: Controller) in controller }
            .initCompleted(wrappingClosure)
    }
}
#endif


extension Container {
#if os(iOS) || os(tvOS)
    /// The typealias to UIViewController.
    public typealias Controller = UIViewController
    
#elseif os(OSX)
    /// The typealias to AnyObject, which should be actually NSViewController or NSWindowController.
    /// See the reference of NSStoryboard.instantiateInitialController method.
    public typealias Controller = AnyObject
    
#endif
}
