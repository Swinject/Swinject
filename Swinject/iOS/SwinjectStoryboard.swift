//
//  SwinjectStoryboard.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import UIKit

public class SwinjectStoryboard: _SwinjectStoryboardBase {
    private var container: Container!
    
    private override init() {
        super.init()
    }
    
    public class func create(name name: String, bundle storyboardBundleOrNil: NSBundle?, container: Container = Container.defaultContainer) -> SwinjectStoryboard {
        // Use this factory method to create an instance because the initializer of UIStoryboard is "not inherited".
        let storyboard = SwinjectStoryboard._create(name, bundle: storyboardBundleOrNil)
        storyboard.container = container
        return storyboard
    }
    
    public override func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
        let viewController = super.instantiateViewControllerWithIdentifier(identifier)
        injectDependency(viewController)
        return viewController
    }
    
    private func injectDependency(viewController: UIViewController) {
        let registrationName = viewController.swinjectRegistrationName
        container.runInitCompleted(viewController.dynamicType, controller: viewController, name: registrationName)
        
        for child in viewController.childViewControllers {
            injectDependency(child)
        }
    }
}
