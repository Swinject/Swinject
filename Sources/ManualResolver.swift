//
//  ManualResolver.swift
//  Swinject
//
//  Created by Brian Radebaugh on 8/12/18.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

/**
 This class is used to registered types where the initializer is controlled by some third party framework
 (i.e. UIViewController, UIView)

 --- Example ---
 ```
 // Object Being Resolved
 class MyViewController: UIViewController {
     var myObject: MyObject!

     init(withCoder coder: Coder) {
         super.init(coder: coder)
         ManualResolver.finishConstruction(me: self)
     }

     init(withNibNameOrNil nibNameOrNil: Coder) {
         super.init(nibNameOrNil: nibNameOrNil)
         ManualResolver.finishConstruction(me: self)
     }

     func inject(myObject: MyObject) {
         self.myObject = myObject
     }
 }

 // Registration
 class MyAssembly: Assembly {
     func assemble(container: Container) {
         container.registerManualConstruction(MyViewController.self) { (resolver, myViewController) in
             let myObject = resolver.resolve(MyObject.self)!
             myViewController.inject(myObject)
         }
     }
 }

 // Starting the Application
 let assembler = Assembler([MyAssembly()], container: ManualResolver.container)
 assembler.resolver.resolve(RootObjectThatKicksEverythingOff.self)
 ```
 */
public class ManualResolver {
    /**
     This is the container all that holds all of the manual registrations.
     */
    public static var container = Container()

    /**
     This property is used to determine if the object being resolved should be resolved, and primarily used for testing.

     During testing, to get the correct test doubles injected you might need to call the inject function manually.
     Instead of having the object injected twice and ensuring that all dependent types are registered properly,
     the ManualResolver can be turned off by setting this property to false.

     Defaults to `true`.
     */
    static var shouldResolve = true

    /**
     This function should be called in all designated initializers (or other logic starting points).

     - Parameter me:    This is the object being resolved.
                        Typically will be passing self in when executing an initializer.
     - Parameter as:    This is the type the object was registered as.
                        Defaults to type inference.
                        If the object is registered as a protocol then that protocol should be specified here.
     - Parameter name:  This is the name for the registration.
                        Typically used for multiple registrations of the same type.
                        Defaults to nil.
     */
    public static func finishConstruction<T>(me object: T, as type: T.Type = T.self, name: String? = nil) {
        guard shouldResolve else {
            return
        }

        typealias FactoryType = ((Resolver, T)) -> Any
        _ = container._resolve(name: name, option: nil) { (factory: FactoryType) in
            factory((self.container, object)) as Any
        } as T?
    }
}

extension Container {
    /**
     This function should be used to register manually resolved objects instead of the standard `register()`.

     - Parameter objectType:        This is the type that is being registered.
     - Parameter name:              This is the name for the registration.
                                    Typically used for multiple registrations of the same type.
                                    Defaults to nil.
     - Parameter injectionHandler:  This is the block that will be executed when the object is resolved.
                                    It provides the resolver and the object being resolved.
                                    In this closure is were the manually created inject function should be called.

     - Returns: The service entry for this registration.
                Typically, this object is ignored during registration or to specify options for the registration
                (i.e. `inObjectScope()`).
     */
    @discardableResult
    public func registerManualConstruction<T>(_ objectType: T.Type,
                                              name: String? = nil,
                                              injectionHandler: @escaping (Resolver, T) -> Void) -> ServiceEntry<T> {
        let factory = { (r: Resolver, o: T) -> T in
            injectionHandler(r, o)
            return o
        }

        return _register(objectType, factory: factory, name: name, option: nil)
    }
}
