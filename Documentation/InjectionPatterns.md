# Injection Patterns

## Initializer Injection

_Initializer injection_ is a pattern for passing  dependencies to a dependent instance by its initializers. Initializer injection is appropriate if the dependent instance cannot work without the dependencies.

The following code defines initializer injection to `PetOwner`, which depends on `AnimalType`:

```swift
let container = Container()
container.register(AnimalType.self) { _ in Cat() }
container.register(PersonType.self) { r in
    PetOwner(pet: r.resolve(AnimalType.self)!)
}
```

Where the protocols and classes are

```swift
protocol AnimalType {
    func sound() -> String
}

class Cat: AnimalType {
    init() { }

    func sound() -> String {
        return "Meow"
    }
}

protocol PersonType { }

class PetOwner: PersonType {
    let pet: AnimalType

    init(pet: AnimalType) {
        self.pet = pet
    }
}
```

Note that the actual type of `AnimalType` passed to the initializer of `PetOwner` is automatically resolved by Swinject when the `PetOwner` instance is created:

## Property Injection

_Property injection_ is a pattern to pass a dependency to a dependent instance via a setter property. Property injection is appropriate if the dependency is optional to the dependent instance.

The following code defines property injection to `PetOwner2`:

```swift
let container = Container()
container.register(AnimalType.self) { _ in Cat() }
container.register(PersonType.self) { r in
    let owner = PetOwner2()
    owner.pet = r.resolve(AnimalType.self)
    return owner
}
```

Where

```swift
class PetOwner2: PersonType {
    var pet: AnimalType?

    init() { }
}
```

Or, you can use <a name="initialization-callback">`initCompleted` callback</a> instead of defining the injection in the registration closure:

```swift
let container = Container()
container.register(AnimalType.self) { _ in Cat() }
container.register(PersonType.self) { _ in PetOwner2() }
    .initCompleted { r, p in
        let owner = p as! PetOwner2
        owner.pet = r.resolve(AnimalType.self)
    }
```

## Method Injection

_Method injection_ is a similar pattern to _property injection_, but it uses a method to pass dependencies to a dependent instance.

The following code defines Method Injection to `PetOwner3`:

```swift
let container = Container()
container.register(AnimalType.self) { _ in Cat() }
container.register(PersonType.self) { r in
    let owner = PetOwner3()
    owner.setPet(r.resolve(AnimalType.self)!)
    return owner
}
```

Where

```swift
class PetOwner3: PersonType {
    var pet: AnimalType?

    init() { }

    func setPet(pet: AnimalType) {
        self.pet = pet
    }
}
```

Or, you can use `initCompleted` callback instead of defining the injection in the registration closure:

```swift
let container = Container()
container.register(AnimalType.self) { _ in Cat() }
container.register(PersonType.self) { _ in PetOwner3() }
    .initCompleted { r, p in
        let owner = p as! PetOwner3
        owner.setPet(r.resolve(AnimalType.self)!)
    }
```

_[Next page: Circular Dependencies](CircularDependencies.md)_

_[Table of Contents](README.md)_
