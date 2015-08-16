# Object Scopes

Object scope is a configuration how an instance provided by a DI container is shared in the system. It is represented by enum `ObjectScope` in Swinject.

The object scope is specified with `inObjectScope` method when you register a pair of a service type and component factory. For example:

    container.register(AnimalType.self) { _ in Cat() }
        .inObjectScope(.Container)

The object scope is ignored if the factory closure returns a value type because its instance is never shared as the specification of Swift.

## None (aka Transient)

If `ObjectScope.None` is specified, an instance provided by a container is not shared. In other words, the container always creates a new instance when the type is resolved.

This scope is also known as Transient in other DI frameworks.

## Graph (the default scope)

In `ObjectScope.Graph`, an instance is always created, like in `ObjectScope.None`, if you directly call `resolve` method of a container, but instances resolved in factory closures are shared during the resolution of the root instance to construct an object graph.

This scope must be specified, or `inObjectScope` must not be called if you register circular dependencies.

## Container (aka Singleton)

In `ObjectScope.Container`, an instance provided by a container is shared within the container. In other words, when you resolve the type at the first time, it is created by the container invoking the factory closure. The instance is returned by the container in the succeeding resolution of the type.

This scope is also known as Singleton in other DI frameworks.

## Hierarchy

In `ObjectScope.Hierarchy`, an instance provided by a container is not only shared within the container but also shared within its child containers.

_[Next page: Misc](Misc.md)_

_[Table of Contents](README.md)_
