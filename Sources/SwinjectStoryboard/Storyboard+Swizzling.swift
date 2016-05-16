//
//  Storyboard+Swizzling.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 10/10/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(tvOS)

private typealias Storyboard = UIStoryboard

#elseif os(OSX)

private typealias Storyboard = NSStoryboard

#endif


#if os(iOS) || os(tvOS) || os(OSX)

extension Storyboard {
    // Class method `load` is not available in Swift. Instead `initialize` is used.
    // http://nshipster.com/swift-objc-runtime/
    public override class func initialize() {
        if self !== Storyboard.self {
            return
        }
        
        struct Static {
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            // Do not use #selector for now to support Xcode 7.2 (Swift 2.1)
            let originalName = "storyboardWithName:bundle:"
            let swizzledName = "swinject_storyboardWithName:bundle:"
            let original = class_getClassMethod(Storyboard.self, Selector(originalName))
            let swizzled = class_getClassMethod(Storyboard.self, Selector(swizzledName))
            method_exchangeImplementations(original, swizzled)
        }
    }
    
    @objc
    private class func swinject_storyboardWithName(name: String, bundle storyboardBundleOrNil: NSBundle) -> Storyboard {
        if self === Storyboard.self {
            // Instantiate SwinjectStoryboard if UI/NSStoryboard is tried to be instantiated.
            return SwinjectStoryboard.create(name: name, bundle: storyboardBundleOrNil)
        } else {
            // Call original `storyboardWithName:bundle:` method swizzled with `swinject_storyboardWithName:bundle:`
            // if SwinjectStoryboard is tried to be instantiated.
            return self.swinject_storyboardWithName(name, bundle: storyboardBundleOrNil)
        }
    }
}

#endif
