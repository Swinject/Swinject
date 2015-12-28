//
//  SwinjectStoryboardType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 10/12/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(OSX) || os(tvOS)

// Objective-C optional protocol method is used instead of protocol extension to workaround the issue that
// default implementation of a protocol method is always called if a class method conforming the protocol
// is defined as an extention in a different framework.
@objc
public protocol SwinjectStoryboardType {
    /// Called by Swinject framework once before SwinjectStoryboard is instantiated.
    ///
    /// - Note:
    ///   Implement this method and setup the default container if you implicitly instantiate UIWindow
    ///   and its root view controller from "Main" storyboard.
    ///
    /// ```swift
    /// extension SwinjectStoryboard {
    ///     class func setup() {
    ///         let container = defaultContainer
    ///         container.register(SomeType.self) {
    ///             _ in
    ///             SomeClass()
    ///         }
    ///         container.registerForStoryboard(ViewController.self) {
    ///             r, c in
    ///             c.something = r.resolve(SomeType.self)
    ///         }
    ///     }
    /// }
    /// ```
    optional static func setup()
}

#endif
