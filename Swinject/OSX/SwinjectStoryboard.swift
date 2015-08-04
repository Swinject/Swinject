//
//  SwinjectStoryboard.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import AppKit

public class SwinjectStoryboard: _SwinjectStoryboardBase {
    private var container: Container!
    
    private override init() {
        super.init()
    }
    
    public class func create(#name: String, bundle storyboardBundleOrNil: NSBundle?, container: Container = Container.defaultContainer) -> SwinjectStoryboard {
        // Use this factory method to create an instance because the initializer of NSStoryboard is "not inherited".
        let storyboard = SwinjectStoryboard._create(name, bundle: storyboardBundleOrNil)
        storyboard.container = container
        return storyboard
    }
    
    public override func instantiateControllerWithIdentifier(identifier: String) -> AnyObject? {
        let controller: AnyObject = super.instantiateControllerWithIdentifier(identifier)!
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
