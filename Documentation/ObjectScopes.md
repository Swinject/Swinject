# Object Scopes

Object scope is a configuration option to determine how an instance provided by a DI container is shared in the system. It is represented by enum `ObjectScope` in Swinject.

The object scope is specified with `inObjectScope` method when you register a pair of a service type and component factory. For example:

```swift
container.register(Animal.self) { _ in Cat() }
    .inObjectScope(.container)
```

The object scope is ignored if the factory closure returns a value type because its instance is never shared per the Swift specification.

## Built-in scopes
### Transient

If `ObjectScope.transient` is specified, an instance provided by a container is not shared. In other words, the container always creates a new instance when the type is resolved.

If this scope is specified, circular dependencies resolution will not work properly.

### Graph (the default scope)

With `ObjectScope.graph`, an instance is always created, as in `ObjectScope.transient`, if you directly call `resolve` method of a container, but instances resolved in factory closures are shared during the resolution of the root instance to construct the object graph.

### Container

In `ObjectScope.container`, an instance provided by a container is shared within the container and its child containers (see [Container Hierarchy](ContainerHierarchy.md)). In other words, when you resolve the type for the first time, it is created by the container by invoking the factory closure. The same instance is returned by the container in any succeeding resolution of the type.

This scope is also known as _Singleton_ in other DI frameworks.

### Weak

In `ObjectScope.weak` an instance provided by a container is shared within the container and its child containers as long as there are other strong references to it. Once all strong references to an instance cease to exist, it won't be shared anymore and new instance will be created during next resolution of the type.

Above holds for reference types - value types are not shared in this object scope.

## Custom Scopes

Custom object scopes can be defined like this:
```swift
extension ObjectScope {
    static let custom = ObjectScope(storageFactory: PermamentStorage.init)
}
```
Instances in `.custom` scope will be shared in the same way as in `.container` scope but can be discarded as needed:
```swift
container.resetObjectScope(.custom)
```
After scope is reset, container will create a new instance first time the type is resolved and will share this instance in any succeeding resolution of the type.

Behavior of custom scopes can be additionally modified by providing different `storageFactory`, or writing custom implementation of `ObjectScopeProtocol` protocol.

_[Next page: Misc](Misc.md)_

_[Table of Contents](README.md)_
