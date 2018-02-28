# Type Forwarding

When the project design follows the [Interface Segregation Principle](https://en.wikipedia.org/wiki/Interface_segregation_principle) there are often objects implementing multiple interfaces. In these cases we usually need to setup dependency injection in a way which ensures that all of those interfaces are resolved to the same instance.

This can - of course - be achieved even without the explicit support, for example:

```swift
class Dog: Animal, Carnivore, Domesticated {}

container.register(Dog.self) { _ in Dog() }
container.register(Animal.self) { $0.resolve(Dog.self)! }
container.register(Carnivore.self) { $0.resolve(Dog.self)! }
contaienr.register(Domesticated.self) { $0.resolve(Dog.self)! }

```

This works well enough, but has a couple of problems: It requires a registration of the concrete type (we may never need to resolve the `Dog` instance explicitly), and introduces some boilerplate (factory closures) which becomes much worse once we introduce the arguments:

```swift
container.register(Dog.self) { _, name in Dog(name: name) }
container.register(Animal.self) { (r, name: String) in r.resolve(Dog.self, argument: name)! }
container.register(Carnivore.self) { (r, name: String) in r.resolve(Dog.self, argument: name)! }
container.register(Domesticated.self) { (r, name: String) in r.resolve(Dog.self, argument: name)! }

```

The same result can be achieved using the Type Forwarding API more efficiently:

```swift
// One way
let service = container.register(Animal.self) { _, name in Dog(name: name) }
container.forward(Carnivore.self, to: service)
container.forward(Domesticated.self, to: service)

// Another way
container.register(Animal.self) { _, name in Dog(name: name) }
	.implements(Carnivore.self, Domesticated.self)
```

When resolving forwarded types, `ServiceEntry` used will be the same as for the initial type, i.e. it will have the same `ObjectScope` and `initCompleted` closures.

## Type safety

Unfortunatelly, there is no way in Swift (yet) to ensure that original registration conforms to the forwarded types. If you define forwarding to an unrelated type there will be a runtime crash during its resolution:

```swift
container.register(Dog.self) { _ in Dog() }
	.implements(Cat.self)

let dog = container.resolve(Dog.self) // all good
let cat = container.resolve(Cat.self) // Precondition failed: Cannot forward Cat to Dog
```