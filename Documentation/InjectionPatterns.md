# Injection Patterns

## Initializer Injection

_Initializer injection_ is a pattern for passing  dependencies to a dependent instance by its initializers. Initializer injection is appropriate if the dependent instance cannot work without the dependencies.

The following code defines initializer injection to `PetOwner`, which depends on `Animal`:

```swift
let container = Container()
container.register(Animal.self) { _ in Cat() }
container.register(Person.self) { r in
    PetOwner(pet: r.resolve(Animal.self)!)
}
```

Where the protocols and classes are

```swift
protocol Animal {
    func sound() -> String
}

class Cat: Animal {
    init() { }

    func sound() -> String {
        return "Meow"
    }
}

protocol Person { }

class PetOwner: Person {
    let pet: Animal

    init(pet: Animal) {
        self.pet = pet
    }
}
```

Note that the actual type of `Animal` passed to the initializer of `PetOwner` is automatically resolved by Swinject when the `PetOwner` instance is created.

## Property Injection

_Property injection_ is a pattern to pass a dependency to a dependent instance via a setter property. Property injection is appropriate if the dependency is optional to the dependent instance, and is required in the case of _[circular dependencies](CircularDependencies.md)_.

The following code defines property injection to `PetOwner2`:

```swift
let container = Container()
container.register(Animal.self) { _ in Cat() }
container.register(Person.self) { _ in PetOwner2() }
    .initCompleted { r, p in
        let owner = p as! PetOwner2
        owner.pet = r.resolve(Animal.self)
    }
```

Where

```swift
class PetOwner2: Person {
    var pet: Animal?

    init() { }
}
```

Note that the <a name="initialization-callback">`initCompleted` callback</a> in some cases is the same as defining the injection in the registration closure (see the following example), but `initCompleted` is preferred since it is able to resolve _[circular dependencies](CircularDependencies.md)_.

```swift
let container = Container()
container.register(Animal.self) { _ in Cat() }
container.register(Person.self) { r in
    let owner = PetOwner2()
    owner.pet = r.resolve(Animal.self)
    return owner
}
```

## Method Injection

_Method injection_ is a similar pattern to _property injection_, but it uses a method to pass dependencies to a dependent instance. It is appropriate when the dependency is encapsulated as a private property.

The following code defines Method Injection to `PetOwner3`:

```swift
let container = Container()
container.register(Animal.self) { _ in Cat() }
container.register(Person.self) { _ in PetOwner3() }
    .initCompleted { r, p in
        let owner = p as! PetOwner3
        owner.setPet(r.resolve(Animal.self)!)
    }
```

Where

```swift
class PetOwner3: Person {
    private var pet: Animal?

    init() { }

    func setPet(pet: Animal) {
        self.pet = pet
    }
}
```

_[Next page: Circular Dependencies](CircularDependencies.md)_

_[Table of Contents](README.md)_
