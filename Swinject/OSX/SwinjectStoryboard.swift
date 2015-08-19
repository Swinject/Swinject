//
//  SwinjectStoryboard.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import AppKit

/// The `SwinjectStoryboard` provides the features defined by its super class `NSStoryboard`,
/// with dependencies of view or window controllers injected.
///
/// To specify a registration name of a view or window controller registered to the `Container` as a service type,
/// add a user defined runtime attribute with the following settings:
///
/// - Key Path: `swinjectRegistrationName`
/// - Type: String
/// - Value: Registration name to the `Container`
///
/// in User Defined Runtime Attributes section on Indentity Inspector pane.
/// If no name is supplied to the registration, no runtime attribute should be specified.
public class SwinjectStoryboard: _SwinjectStoryboardBase {
    private var container: Container!
    
    private override init() {
        super.init()
    }
    
    /// Creates the new instance of `SwinjectStoryboard`. This method is used instead of an initializer.
    ///
    /// :param: name      The name of the storyboard resource file without the filename extension.
    /// :param: bundle    The bundle containing the storyboard file and its resources. Specify nil to use the main bundle.
    /// :param: container The container with registrations of the view or window controllers in the storyboard and their dependencies.
    ///                   The shared singleton container `Container.defaultContainer` is used if no container is passed.
    ///
    /// :returns: The new instance of `SwinjectStoryboard`.
    public class func create(name name: String, bundle storyboardBundleOrNil: NSBundle?, container: Container = Container.defaultContainer) -> SwinjectStoryboard {
        // Use this factory method to create an instance because the initializer of NSStoryboard is "not inherited".
        let storyboard = SwinjectStoryboard._create(name, bundle: storyboardBundleOrNil)
        storyboard.container = container
        return storyboard
    }
    
    /// Instantiates the view or window controller with the specified identifier.
    /// The view or window controller and its child controllers have their dependencies injected
    /// as specified in the `Container` passed to the initializer of the `SwinjectStoryboard`.
    ///
    /// :param: identifier The identifier set in the storyboard file.
    ///
    /// :returns: The instantiated view or window controller with its dependencies injected.
    public override func instantiateControllerWithIdentifier(identifier: String) -> AnyObject {
        let controller = super.instantiateControllerWithIdentifier(identifier)
        injectDependency(controller)
        return controller
    }
    
    private func injectDependency(controller: AnyObject) {
        let registrationName = (controller as! RegistrationNameAssociatable).swinjectRegistrationName
        if let viewController = controller as? NSViewController {
            container.runInitCompleted(viewController.dynamicType, controller: viewController, name: registrationName)
        
            for child in viewController.childViewControllers {
                injectDependency(child)
            }
        }
        else if let windowController = controller as? NSWindowController {
            container.runInitCompleted(windowController.dynamicType, controller: windowController, name: registrationName)
        }
    }
}
