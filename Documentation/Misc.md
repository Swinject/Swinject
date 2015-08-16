# Misc

## Value Types

Swift 2 has introduced [Protocol Extensions](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID521), which reinforces [Protocol Oriented Programming](http://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2) and usage of value types. Swinject can handle not only a reference type but also a value type as a component created by a factory.

Here you have `Turtle` struct implementing `AnimalType` protocol.

    protocol AnimalType {
        var name: String { get set }
    }

    struct Turtle: AnimalType {
        var name: String
    }

The struct instance can be registered and resolved as below.

    let container = Container()
    container.register(AnimalType.self) { _ in Turtle(name: "Ninja") }

    var turtle1 = container.resolve(AnimalType.self)!
    print(turtle1.name) // prints "Ninja"

Because `turtle1` is actually a struct instance although its type is inferred as protocol `AnimalType` there, assigning it to a new parameter creates a new instance.

    var turtle2 = turtle1
    turtle2.name = "Samurai"
    print(turtle2.name) // prints "Samurai"
    print(turtle1.name) // prints "Ninja"

## Self-registration (Self-binding)

In Swinject or other DI frameworks, a service type can be not only a protocol but also a concrete or abstract classes. A special case is that the service type and component type are identical. The case is called Self-registration or Self-binding. Here is an example of self-binding with Swinject.

    let container = Container()
    container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
    container.register(PetOwner.self) { r in
        PetOwner(name: "Selfie", pet: r.resolve(AnimalType.self)!)
    }

Then a `PetOnwer` service is resolved as itself.

    let owner = container.resolve(PetOwner.self)!
    print(owner.name) // prints "Selfie"
    print(owner.pet.name) // prints "Mimi"

Where the protocols and classes are:

    protocol AnimalType {
        var name: String { get set }
    }

    class Cat: AnimalType {
        var name: String

        init(name: String) {
            self.name = name
        }
    }

    class PetOwner {
        let name: String
        let pet: AnimalType

        init(name: String, pet: AnimalType) {
            self.name = name
            self.pet = pet
        }
    }

## Shared Singleton Container

`Container` class has its singleton instance to use everywhere. The shared singleton is provided by `defaultContainer` class property. For example, if `PetOwner` depends on `AnimalType`, first register the `AnimalType` to the singleton container.

    Container.defaultContainer.register(AnimalType.self) { _ in
        Cat(name: "Mew")
    }

Then `PetOwner` class can get the dependency from the shared container.

    class PetOwner {
        let name: String
        let pet: AnimalType

        init(name: String) {
            self.name = name
            self.pet = Container.defaultContainer.resolve(AnimalType.self)!
        }
    }

This pattern is more like [Service Locator Pattern](https://en.wikipedia.org/wiki/Service_locator_pattern) although some people think [it is an anti pattern](http://stackoverflow.com/questions/22795459/is-servicelocator-anti-pattern).

_[Next page: Storyboard](Storyboard.md)_

_[Table of Contents](README.md)_
