# DI Container

[Dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) (DI) is a software design pattern that uses [inversion of control](https://en.wikipedia.org/wiki/Inversion_of_control) (IoC) for resolving dependencies. A DI _container_ manages the type dependencies of your system. First, you register the  types that should be resolved, with their dependencies. Then you use the DI container to get instances of those types whose dependencies are then automatically resolved by the DI container. In Swinject, the `Container` class represents the DI container.

Unfortunately, implementations of dependency injection often use slightly different terminology, which if not explained clearly in advance can cause confusion. In Swinject we define the following terms:

* **Service**: A protocol defining an interface for a dependent type.
* **Component**: An actual type implementing a service.
* **Factory**: A function or closure instantiating a component.
* **Container**: A collection of component instances.

Note the terms _service instance_ and _component instance_ mean the same thing, and are used interchangeably.

## Registration in a DI Container

A service and its corresponding component are registered with the `register` method of the container. The method takes the service type for the component and a factory method. If the component depends on another service, the factory method can call `resolve` on the passed in resolver objection to "inject" the dependency. The actual underlying type of the dependency will be determined later when the component instance is created.

Here is an example of service registration:

```swift
let container = Container()
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(Person.self) { r in
    PetOwner(name: "Stephen", pet: r.resolve(Animal.self)!)
}
```

Where the protocols and classes are:

```swift
protocol Animal {
    var name: String { get }
}
protocol Person {
    var name: String { get }
}

class Cat: Animal {
    let name: String

    init(name: String) {
        self.name = name
    }
}

class PetOwner: Person {
    let name: String
    let pet: Animal

    init(name: String, pet: Animal) {
        self.name = name
        self.pet = pet
    }
}
```

After you register the components, you can get service instances from the container by calling the `resolve` method. It returns resolved components with the specified service (protocol) types.

```swift
let animal = container.resolve(Animal.self)!
let person = container.resolve(Person.self)!
let pet = (person as! PetOwner).pet

print(animal.name) // prints "Mimi"
print(animal is Cat) // prints "true"
print(person.name) // prints "Stephen"
print(person is PetOwner) // prints "true"
print(pet.name) // prints "Mimi"
print(pet is Cat) // prints "true"
```

Here the instances resolved by the `resolve` method are unwrapped with `!` because it returns `nil` if no registration for the specified service type is found.

## Named Registration in a DI Container

If you would like to register two or more components for a service type, you can name the registrations to differentiate.

```swift
let container = Container()
container.register(Animal.self, name: "cat") { _ in Cat(name: "Mimi") }
container.register(Animal.self, name: "dog") { _ in Dog(name: "Hachi") }
```

Then you can get the service instances with the registered names:

```swift
let cat = container.resolve(Animal.self, name:"cat")!
let dog = container.resolve(Animal.self, name:"dog")!

print(cat.name) // prints "Mimi"
print(cat is Cat) // prints "true"
print(dog.name) // prints "Hachi"
print(dog is Dog) // prints "true"
```

Where `Dog` class is:

```swift
class Dog: Animal {
    let name: String

    init(name: String) {
        self.name = name
    }
}
```

## Registration with Arguments in a DI Container

The factory closure passed to the `register` method can take arguments that are passed when the service is resolved. When you register the service, the arguments can be specified after the `Resolvable` parameter. Note that if the resolver is not use it can be given as `_` as in the following example (this is practice in  Swift):

```swift
container.register(Animal.self) { _, name in
    Horse(name: name)
}
container.register(Animal.self) { _, name, running in
    Horse(name: name, running: running)
}
```

Then pass runtime arguments when you call `resolve` method. If you pass only 1 argument, use `resolve(_:argument:)`.

```swift
let animal1 = container.resolve(Animal.self, argument: "Spirit")!

print(animal1.name) // prints "Spirit"
print((animal1 as! Horse).running) // prints "false"
```

If you pass 2 arguments or more, use `resolve(_:arguments:,_:)`.

```swift
let animal2 = container.resolve(Animal.self, arguments: "Lucky", true)!

print(animal2.name) // prints "Lucky"
print((animal2 as! Horse).running) // prints "true"
```

Where the `Horse` class is:

```swift
class Horse: Animal {
    let name: String
    let running: Bool

    convenience init(name: String) {
        self.init(name: name, running: false)
    }

    init(name: String, running: Bool) {
        self.name = name
        self.running = running
    }
}
```

## Registration Keys

A registration of the component for a given service is stored in a container with an internally created key. The container uses the key when trying to resolve a service dependency.

The key consists of:

* The type of the service
* The name of the registration
* The number and types of the arguments

If a registration matches an existing registration with all the parts of the key, the existing registration is _overwritten_ with the new registration.

For example, the following registrations can co-exist in a container because the service _types_ are different:

```swift
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(Person.self) { r in
    PetOwner(name: "Stephen", pet: r.resolve(Animal.self)!)
}
```

The following registrations can co-exist in a container because the registration _names_ are different:

```swift
container.register(Animal.self, name: "cat") { _ in Cat(name: "Mimi") }
container.register(Animal.self, name: "dog") { _ in Dog(name: "Hachi") }
```

The following registrations can co-exist in a container because the _numbers of arguments_ are different. The first registration has no arguments, and the second has an argument:

```swift
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(Animal.self) { _, name in Cat(name: name) }
```

The following registrations can co-exist in a container because the _types of the arguments_ are different. The first registration has `String` and `Bool` types. The second registration has `Bool` and `String` types in the order:

```swift
container.register(Animal.self) { _, name, running in
    Horse(name: name, running: running)
}
container.register(Animal.self) { _, running, name in
    Horse(name: name, running: running)
}
```

### Remark

Be careful with the types of arguments when you resolve an instance from a container. To resolve it as you expect, the types must be inferred as the same types as those you register to the container.

```swift
// Registers with name argument as String.
// The argument is inferred as String because Cat initializer takes an argument as String.
// The Registration Key is (Animal, (String) -> Animal)
container.register(Animal.self) { _, name in Cat(name: name) }

// This is the correct Registration Key (Animal, (String) -> Animal)
let name1: String = "Mimi"
let mimi1 = container.resolve(Animal.self, argument: name1) // Returns a Cat instance.

// Cannot resolve since the container has no Registration Key matching (Animal, (NSString) -> Animal)
let name2: NSString = "Mimi"
let mimi2 = container.resolve(Animal.self, argument: name2) // Returns nil.

// Cannot resolve since the container has no Registration Key matching (Animal, (Optional<String>) -> Animal)
let name3: String? = "Mimi"
let mimi3 = container.resolve(Animal.self, argument: name3) // Returns nil.

// Cannot resolve since the container has no Registration Key matching (Animal, (ImplicitlyUnwrappedOptional<String>) -> Animal)
let name4: String! = "Mimi"
let mimi4 = container.resolve(Animal.self, argument: name4) // Returns nil.
```

_[Next page: Injection Patterns](InjectionPatterns.md)_

_[Table of Contents](README.md)_
