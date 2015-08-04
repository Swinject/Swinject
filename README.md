# Swinject

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Swinject is a [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) framework for Swift, inspired by [Ninject](http://ninject.org), [Autofac](http://autofac.org), [Typhoon](http://typhoonframework.org), and highly inspired by [Funq](http://funq.codeplex.com).

## Features

- [x] Initializer/Property/Method Injections
- [x] Initialization Callback
- [x] Circular Dependency Injection
- [x] Injection with Arguments
- [x] Self-binding
- [x] Container Hierarchy
- [x] Object Scopes as None (Transient), Graph, Container (Singleton) and Hierarchy
- [x] Injection of both Reference and Value Types
- [x] Storyboard

## Requirements

- iOS 8.0+ / Mac OS X 10.10+
- Xcode 7.0 beta 4

## Installation

### Carthage

To install Swinject with [Carthage](https://github.com/Carthage/Carthage), add the following line to your `Cartfile`.

    github "Swinject/Swinject" ~> 0.2


Then run `carthage update` command. For details of the installation and usage of Carthage, visit [its project page](https://github.com/Carthage/Carthage).


### CocoaPods

Will be supported.


## Dependency Injection

Dependency Injection (DI) is a software design pattern that implements Inversion of Control (IoC) for resolving dependencies.

## Example of Use

First, register a service and component pair to a `Container`, where the component is created by the registered closure as a factory. In this example, `Cat` and `PetOwner` are component classes implementing `AnimalType` and `PersonType` service protocols, respectively.

    let container = Container()
    container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
    container.register(PersonType.self) { r in
         PetOwner(pet: r.resolve(AnimalType.self)!)
    }

Then get an instance of a service from the container. The person is resolved to a pet owner, and playing with the cat named Mimi!

    let person = container.resolve(PersonType.self)!
    person.play() // prints "I'm playing with Mimi."

Where definitions of the protocols and classes are

    protocol AnimalType {
        var name: String? { get }
    }

    class Cat: AnimalType {
        let name: String?

        init(name: String?) {
            self.name = name
        }
    }

and

    protocol PersonType {
        func play()
    }

    class PetOwner: PersonType {
        let pet: AnimalType

        init(pet: AnimalType) {
            self.pet = pet
        }

        func play() {
            let name = pet.name ?? "someone"
            print("I'm playing with \(name).")
        }
    }

Notice that the `pet` of `PetOwner` is automatically set as the instance of `Cat` when `PersonType` is resolved to the instance of `PetOwner`. If a container already set up is given, you do not have to care what are the actual types of the services and how they are created with their dependency.

## License

MIT license. See the `LICENSE` file for details.
