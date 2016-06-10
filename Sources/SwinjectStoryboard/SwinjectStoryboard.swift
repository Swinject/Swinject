//
//  SwinjectStoryboard.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(OSX)

/// The `SwinjectStoryboard` provides the features to inject dependencies of view/window controllers in a storyboard.
///
/// To specify a registration name of a view/window controller registered to the `Container` as a service type,
/// add a user defined runtime attribute with the following settings:
///
/// - Key Path: `swinjectRegistrationName`
/// - Type: String
/// - Value: Registration name to the `Container`
///
/// in User Defined Runtime Attributes section on Indentity Inspector pane.
/// If no name is supplied to the registration, no runtime attribute should be specified.
public class SwinjectStoryboard: _SwinjectStoryboardBase, SwinjectStoryboardType {
    /// A shared container used by SwinjectStoryboard instances that are instantiated without specific containers.
    ///
    /// Typical usecases of this property are:
    /// - Implicit instantiation of UIWindow and its root view controller from "Main" storyboard.
    /// - Storyboard references to transit from a storyboard to another.
    public static var defaultContainer = Container()
    
    // Boxing to workaround a runtime error [Xcode 7.1.1 and Xcode 7.2 beta 4]
    // If container property is ResolverType type and a ResolverType instance is assigned to the property,
    // the program crashes by EXC_BAD_ACCESS, which looks a bug of Swift.
    private var container: Box<ResolverType>!
    
    /// Do NOT call this method explicitly. It is designed to be called by the runtime.
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            (SwinjectStoryboard.self as SwinjectStoryboardType.Type).setup?()
        }
    }

    private override init() {
        super.init()
    }

    /// Creates the new instance of `SwinjectStoryboard`. This method is used instead of an initializer.
    ///
    /// - Parameters:
    ///   - name:      The name of the storyboard resource file without the filename extension.
    ///   - bundle:    The bundle containing the storyboard file and its resources. Specify nil to use the main bundle.
    ///   - container: The container with registrations of the view/window controllers in the storyboard and their dependencies.
    ///                The shared singleton container `SwinjectStoryboard.defaultContainer` is used if no container is passed.
    ///
    /// - Returns: The new instance of `SwinjectStoryboard`.
    public class func create(
        name name: String,
        bundle storyboardBundleOrNil: NSBundle?,
        container: ResolverType = SwinjectStoryboard.defaultContainer) -> SwinjectStoryboard
    {
        // Use this factory method to create an instance because the initializer of UI/NSStoryboard is "not inherited".
        let storyboard = SwinjectStoryboard._create(name, bundle: storyboardBundleOrNil)
        storyboard.container = Box(container)
        return storyboard
    }


#if os(iOS) || os(tvOS)
    /// Instantiates the view controller with the specified identifier.
    /// The view controller and its child controllers have their dependencies injected
    /// as specified in the `Container` passed to the initializer of the `SwinjectStoryboard`.
    ///
    /// - Parameter identifier: The identifier set in the storyboard file.
    ///
    /// - Returns: The instantiated view controller with its dependencies injected.
    public override func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
        let viewController = super.instantiateViewControllerWithIdentifier(identifier)
        injectDependency(viewController)
        return viewController
    }
    
    private func injectDependency(viewController: UIViewController) {
        let registrationName = viewController.swinjectRegistrationName

        // Xcode 7.1 workaround for Issue #10. This workaround is not necessary with Xcode 7.
        // The actual controller type is distinguished by the dynamic type name in `nameWithActualType`.
        //
        // If a future update of Xcode fixes the problem, replace the resolution with the following code and fix registerForStoryboard too:
        //    container.resolve(controller.dynamicType, argument: controller as Container.Controller, name: registrationName)
        let nameWithActualType = String(reflecting: viewController.dynamicType) + ":" + (registrationName ?? "")
        container.value.resolve(Container.Controller.self, name: nameWithActualType, argument: viewController as Container.Controller)

        for child in viewController.childViewControllers {
            injectDependency(child)
        }
    }
    
#elseif os(OSX)
    /// Instantiates the view/Window controller with the specified identifier.
    /// The view/window controller and its child controllers have their dependencies injected
    /// as specified in the `Container` passed to the initializer of the `SwinjectStoryboard`.
    ///
    /// - Parameter identifier: The identifier set in the storyboard file.
    ///
    /// - Returns: The instantiated view/window controller with its dependencies injected.
    public override func instantiateControllerWithIdentifier(identifier: String) -> AnyObject {
        let controller = super.instantiateControllerWithIdentifier(identifier)
        injectDependency(controller)
        return controller
    }
    
    private func injectDependency(controller: Container.Controller) {
        let registrationName = (controller as? RegistrationNameAssociatable)?.swinjectRegistrationName
        
        // Xcode 7.1 workaround for Issue #10. This workaround is not necessary with Xcode 7.
        // The actual controller type is distinguished by the dynamic type name in `nameWithActualType`.
        //
        // If a future update of Xcode fixes the problem, replace the resolution with the following code and fix registerForStoryboard too:
        //    container.resolve(controller.dynamicType, argument: controller as Container.Controller, name: registrationName)
        let nameWithActualType = String(reflecting: controller.dynamicType) + ":" + (registrationName ?? "")
        container.value.resolve(Container.Controller.self, name: nameWithActualType, argument: controller as Container.Controller)
        
        if let viewController = controller as? NSViewController {
            for child in viewController.childViewControllers {
                injectDependency(child)
            }
        }
    }
#endif
}

#endif
