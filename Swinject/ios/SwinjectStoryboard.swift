//
//  SwinjectStoryboard.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import UIKit

public class SwinjectStoryboard: UIStoryboard {
    private var container: Container!
    
    private override init() {
        super.init()
    }
    
    public class func create(name name: String, bundle storyboardBundleOrNil: NSBundle?) -> SwinjectStoryboard {
        return SwinjectStoryboard.create(name: name, bundle: storyboardBundleOrNil, container: Container.defaultContainer)
    }
    
    public class func create(name name: String, bundle storyboardBundleOrNil: NSBundle?, container: Container) -> SwinjectStoryboard {
        let storyboard = UIStoryboard(name: name, bundle: storyboardBundleOrNil)
        object_setClass(storyboard, SwinjectStoryboard.self)
        let swinjectStoryboard = storyboard as! SwinjectStoryboard
        swinjectStoryboard.container = container
        return swinjectStoryboard
    }
    
    public override func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
        let viewController = super.instantiateViewControllerWithIdentifier(identifier)
        self.injectDependency(viewController)
        return viewController;
    }
    
    private func injectDependency(viewController: UIViewController) {
        // TODO: Inject depnendency by the container.
        
        for child in viewController.childViewControllers {
            self.injectDependency(child)
        }
    }
}
