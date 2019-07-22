# Container Hierarchy

A container hierarchy is a tree of containers for the purposes of sharing the registrations of dependency injections. Service types registered to a parent container can be resolved in its child containers too. Use `init(parent: Container)` to instantiate a child container while specifying its parent container:

```swift
let parentContainer = Container()
parentContainer.register(Animal.self) { _ in Cat() }
let childContainer = Container(parent: parentContainer)

let cat = childContainer.resolve(Animal.self)
print(cat != nil) // prints "true"
```

In contrast, service types registered to a child container are _not_ resolved in its parent container:

```swift
let parentContainer = Container()
let childContainer = Container(parent: parentContainer)
childContainer.register(Animal.self) { _ in Cat() }

let cat = parentContainer.resolve(Animal.self)
print(cat == nil) // prints "true"
```

_[Next page: Modularizing Service Registration (Assembly)](Assembler.md)_

_[Table of Contents](README.md)_
