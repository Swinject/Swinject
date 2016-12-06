# Misc

## Value Types

Swift 2 has introduced [Protocol Extensions](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID521), which reinforces [Protocol Oriented Programming](http://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2) and usage of value types. Swinject can handle not only a reference type but also a value type as a component created by a factory.

Here you have `Turtle` struct implementing `Animal` protocol.

```swift
protocol Animal {
    var name: String { get set }
}

struct Turtle: Animal {
    var name: String
}
```

The struct instance can be registered and resolved as below.

```swift
let container = Container()
container.register(Animal.self) { _ in Turtle(name: "Ninja") }

var turtle1 = container.resolve(Animal.self)!
print(turtle1.name) // prints "Ninja"
```

Because `turtle1` is actually a struct instance although its type is inferred as protocol `Animal` there, assigning it to a new parameter creates a new instance.

```swift
var turtle2 = turtle1
turtle2.name = "Samurai"
print(turtle2.name) // prints "Samurai"
print(turtle1.name) // prints "Ninja"
```

## Self-registration (Self-binding)

In Swinject or other DI frameworks, a service type can not only be a protocol but also a concrete or abstract classes. A special case is when the service type and component type are identical. This case is called _self-registration_ or _self-binding_. Here is an example of self-binding with Swinject:

```swift
let container = Container()
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(PetOwner.self) { r in
    PetOwner(name: "Selfie", pet: r.resolve(Animal.self)!)
}
```

Then a `PetOwner` service is resolved as itself:

```swift
let owner = container.resolve(PetOwner.self)!
print(owner.name) // prints "Selfie"
print(owner.pet.name) // prints "Mimi"
```

Where the protocols and classes are:

```swift
protocol Animal {
    var name: String { get set }
}

class Cat: Animal {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class PetOwner {
    let name: String
    let pet: Animal

    init(name: String, pet: Animal) {
        self.name = name
        self.pet = pet
    }
}
```

## Resolution failure logging

When `resolve` method fails, Swinject will log information about expected and available registrations to make DI debugging easier. This feature can be disabled / customized by modifying `Container.loggingFunction` variable, e.g.:
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Container.loggingFunction = nil // disable logging
    ...
}
```

_[Next page: Container Hierarchy](ContainerHierarchy.md)_

_[Table of Contents](README.md)_
