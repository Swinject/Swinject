<p align="center">
  <img src="https://avatars0.githubusercontent.com/u/13637225?v=3&s=600" width="33%">
</p>

Swinject
========

[![Travis CI Com](https://travis-ci.com/Swinject/Swinject.svg?branch=master)](https://travis-ci.com/Swinject/Swinject)
![Github Actions](https://github.com/1ucas/Swinject/actions/workflows/Project%20Testing.yml/badge.svg?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Swinject.svg?style=flat)](http://cocoapods.org/pods/Swinject)
[![License](https://img.shields.io/cocoapods/l/Swinject.svg?style=flat)](http://cocoapods.org/pods/Swinject)
[![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](http://cocoapods.org/pods/Swinject)
[![Swift Version](https://img.shields.io/badge/Swift-4.2--5.4-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

Swinject is a lightweight [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) framework for Swift.

Dependency injection (DI) is a software design pattern that implements Inversion of Control (IoC) for resolving dependencies. In the pattern, Swinject helps your app split into loosely-coupled components, which can be developed, tested and maintained more easily. Swinject is powered by the Swift generic type system and first class functions to define dependencies of your app simply and fluently.

## Features

- [x] [Pure Swift Type Support](./Documentation/README.md#user-content-pure-swift-type-support)
- [x] [Injection with Arguments](./Documentation/DIContainer.md#registration-with-arguments-to-di-container)
- [x] [Initializer/Property/Method Injections](./Documentation/InjectionPatterns.md)
- [x] [Initialization Callback](./Documentation/InjectionPatterns.md#user-content-initialization-callback)
- [x] [Circular Dependency Injection](./Documentation/CircularDependencies.md)
- [x] [Object Scopes as None (Transient), Graph, Container (Singleton) and Hierarchy](./Documentation/ObjectScopes.md)
- [x] Support of both Reference and [Value Types](./Documentation/Misc.md#value-types)
- [x] [Self-registration (Self-binding)](./Documentation/Misc.md#self-registration-self-binding)
- [x] [Container Hierarchy](./Documentation/ContainerHierarchy.md)
- [x] [Thread Safety](./Documentation/ThreadSafety.md)
- [x] [Modular Components](./Documentation/Assembler.md)

## Extensions

- **[SwinjectPropertyLoader](https://github.com/Swinject/SwinjectPropertyLoader)**: Loading property values from resources.
- **[SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard)**: Automatic dependency injection via Storyboard.
- **[Swinject-CodeGen](https://github.com/Swinject/Swinject-CodeGen)**: Type-safe code generation of `Container` from a CSV/YAML file defining dependencies.
- **[SwinjectAutoregistration](https://github.com/Swinject/SwinjectAutoregistration)**: Automatic registration of services by leveraging the Swift Generics.

## Requirements

- iOS 9.0+ / Mac OS X 10.10+ / watchOS 2.0+ / tvOS 9.0+
- Xcode 10.2+
- Swift 4.2+
- Carthage 0.18+ (if you use)
- CocoaPods 1.1.1+ (if you use)

## Installation

Swinject is available through [Carthage](https://github.com/Carthage/Carthage), [CocoaPods](https://cocoapods.org), or [Swift Package Manager](https://swift.org/package-manager/).

### Carthage

To install Swinject with Carthage, add the following line to your `Cartfile`.

```
github "Swinject/Swinject"

# Uncomment if you use SwinjectStoryboard
# github "Swinject/SwinjectStoryboard"
```

Then run `carthage update --no-use-binaries` command or just `carthage update`. For details of the installation and usage of Carthage, visit [its project page](https://github.com/Carthage/Carthage).


### CocoaPods

To install Swinject with CocoaPods, add the following lines to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0' # or platform :osx, '10.10' if your target is OS X.
use_frameworks!

pod 'Swinject'

# Uncomment if you use SwinjectStoryboard
# pod 'SwinjectStoryboard'
```

Then run `pod install` command. For details of the installation and usage of CocoaPods, visit [its official website](https://cocoapods.org).

### Swift Package Manager

in `Package.swift` add the following:

```swift
dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
],
targets: [
    .target(
        name: "MyProject",
        dependencies: [..., "Swinject"]
    )
    ...
]
```

## Documentation

- [Technical documents](./Documentation) including patterns of dependency injection and examples.
- [API reference](http://cocoadocs.org/docsets/Swinject/)

## Basic Usage

First, register a service and component pair to a `Container`, where the component is created by the registered closure as a factory. In this example, `Cat` and `PetOwner` are component classes implementing `Animal` and `Person` service protocols, respectively.

```swift
let container = Container()
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(Person.self) { r in
    PetOwner(pet: r.resolve(Animal.self)!)
}
```

Then get an instance of a service from the container. The person is resolved to a pet owner, and playing with the cat named Mimi!

```swift
let person = container.resolve(Person.self)!
person.play() // prints "I'm playing with Mimi."
```

Where definitions of the protocols and classes are

```swift
protocol Animal {
    var name: String? { get }
}

class Cat: Animal {
    let name: String?

    init(name: String?) {
        self.name = name
    }
}
```

and

```swift
protocol Person {
    func play()
}

class PetOwner: Person {
    let pet: Animal

    init(pet: Animal) {
        self.pet = pet
    }

    func play() {
        let name = pet.name ?? "someone"
        print("I'm playing with \(name).")
    }
}
```

Notice that the `pet` of `PetOwner` is automatically set as the instance of `Cat` when `Person` is resolved to the instance of `PetOwner`. If a container already set up is given, you do not have to care what are the actual types of the services and how they are created with their dependency.

## Where to Register Services

Services must be registered to a container before they are used. The typical registration approach will differ depending upon whether you are using `SwinjectStoryboard` or not.

The following view controller class is used in addition to the protocols and classes above in the examples below.

```swift
class PersonViewController: UIViewController {
    var person: Person?
}
```

### With SwinjectStoryboard

Import SwinjectStoryboard at the top of your swift source file.

```swift
import SwinjectStoryboard
```

Services should be registered in an extension of `SwinjectStoryboard` if you use `SwinjectStoryboard`. Refer to [the project page of SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard) for further details.

```swift
extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.register(Animal.self) { _ in Cat(name: "Mimi") }
        defaultContainer.register(Person.self) { r in
            PetOwner(pet: r.resolve(Animal.self)!)
        }
        defaultContainer.register(PersonViewController.self) { r in
            let controller = PersonViewController()
            controller.person = r.resolve(Person.self)
            return controller
        }
    }
}
```

### Without SwinjectStoryboard

If you do not use `SwinjectStoryboard` to instantiate view controllers, services should be registered to a container in your application's `AppDelegate`. Registering before exiting `application:didFinishLaunchingWithOptions:` will ensure that the services are setup appropriately before they are used.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let container: Container = {
        let container = Container()
        container.register(Animal.self) { _ in Cat(name: "Mimi") }
        container.register(Person.self) { r in
            PetOwner(pet: r.resolve(Animal.self)!)
        }
        container.register(PersonViewController.self) { r in
            let controller = PersonViewController()
            controller.person = r.resolve(Person.self)
            return controller
        }
        return container
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        // Instantiate the root view controller with dependencies injected by the container.
        window.rootViewController = container.resolve(PersonViewController.self)

        return true
    }
}
```

Notice that the example uses a convenience initializer taking a closure to register services to the new instance of `Container`.

## Play in Playground!

The project contains `Sample-iOS.playground` to demonstrate the features of Swinject. Download or clone the project, run the playground, modify it, and play with it to learn Swinject.

To run the playground in the project, first build the project, then select `Editor > Execute Playground` menu in Xcode.

## Example Apps

Some example apps using Swinject can be found on [GitHub](https://github.com/search?o=desc&q=swinject&s=updated&type=Repositories).

## Blog Posts

The following blog posts introduce the concept of dependency injection and Swinject.

- [Dependency Injection Tutorial for iOS: Getting Started](https://www.raywenderlich.com/14223279-dependency-injection-tutorial-for-ios-getting-started) *by [Irina Galata](https://www.raywenderlich.com/u/galata)*
- [Swinject Tutorial for iOS: Getting Started](https://www.raywenderlich.com/17-swinject-tutorial-for-ios-getting-started) *by [Gemma Barlow](https://www.raywenderlich.com/u/gemmakbarlow)*
- [iOS Dependency Injection Using Swinject](https://medium.com/flawless-app-stories/ios-dependency-injection-using-swinject-9c4ceff99e41) *by [Ali Akhtar](https://ali-akhtar.medium.com)*
- [DI in iOS: Complete guide](https://medium.com/its-tinkoff/di-in-ios-complete-guide-cd76a079d2d) *by [Vitaly Batrakov](https://medium.com/@batrakov.vitaly)*

Thanks the authors!

## Contribution Guide

A guide to [submit issues](https://github.com/Swinject/Swinject/issues), to ask general questions, or to [open pull requests](https://github.com/Swinject/Swinject/pulls) is [here](CONTRIBUTING.md).

## Question?

- [Stack Overflow](https://stackoverflow.com/questions/tagged/swinject) we are trying to monitor questions tagged `swinject`

## Credits

The DI container features of Swinject are inspired by:

- [Ninject](http://ninject.org) - [Enkari, Ltd](https://github.com/enkari) and [the Ninject project contributors](https://github.com/ninject/Ninject/graphs/contributors).
- [Autofac](http://autofac.org) - [Autofac Project](https://github.com/autofac/Autofac).

and highly inspired by:

- [Funq](http://funq.codeplex.com) - [Daniel Cazzulino](http://www.codeplex.com/site/users/view/dcazzulino) and [the project team](http://funq.codeplex.com/team/view).

## License

MIT license. See the [LICENSE file](LICENSE) for details.
