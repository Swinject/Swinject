# Container Hierarchy

A container hierarchy is a relationship of containers to share registrations of dependency injections. Service types registered to a parent container can be resolved in its child containers too. Use `init(parent: Container)` to instantiate a child container with its parent passed.

    let parentContainer = Container()
    parentContainer.register(AnimalType.self) { _ in Cat() }
    let childContainer = Container(parent: parentContainer)

    let cat = childContainer.resolve(AnimalType.self)
    print(cat != nil) // prints "true"

In contrast, service types registered to a child container are not resolved in its parent container.

    let parentContainer = Container()
    let childContainer = Container(parent: parentContainer)
    childContainer.register(AnimalType.self) { _ in Cat() }

    let cat = parentContainer.resolve(AnimalType.self)
    print(cat == nil) // prints "true"

_[Next page: Object Scopes](ObjectScopes.md)_

_[Table of Contents](README.md)_
