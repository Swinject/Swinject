# Object Scopes

Object scope is a configuration option to determine how an instance provided by a DI container is shared in the system. It is represented by enum `ObjectScope` in Swinject.

The object scope is specified with `inObjectScope` method when you register a pair of a service type and component factory. For example:

```swift
container.register(AnimalType.self) { _ in Cat() }
    .inObjectScope(.Container)
```

The object scope is ignored if the factory closure returns a value type because its instance is never shared per the Swift specification.

## None (aka Transient)

If `ObjectScope.None` is specified, an instance provided by a container is not shared. In other words, the container always creates a new instance when the type is resolved.

This scope is also known as _Transient_ in other DI frameworks.

## Graph (the default scope)

With `ObjectScope.Graph`, an instance is always created, as in `ObjectScope.None`, if you directly call `resolve` method of a container, but instances resolved in factory closures are shared during the resolution of the root instance to construct the object graph.

This scope must be specified, or `inObjectScope` must not be called if you register circular dependencies.

## Container (aka Singleton)

In `ObjectScope.Container`, an instance provided by a container is shared within the container. In other words, when you resolve the type for the first time, it is created by the container by invoking the factory closure. The same instance is returned by the container in any succeeding resolution of the type.

This scope is also known as _Singleton_ in other DI frameworks.

## Hierarchy

In `ObjectScope.Hierarchy`, an instance provided by a container is not only shared within the container but also shared within its child containers. Refer to [Container Hierarchy](ContainerHierarchy.md) for parent-child relationship of containers.

_[Next page: Misc](Misc.md)_

_[Table of Contents](README.md)_
