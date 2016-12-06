# Circular Dependencies

_Circular dependencies_ are dependencies of instances that depend on each other. To define circular dependencies in Swinject, one of the dependencies must be injected through a property.

## Initializer/Property Dependencies

Assume that you have `Parent` and `Child` classes depending on each other. `Parent` depends on `ChildProtocol` through its initializer, and `Child` on `ParentProtocol` through a property. The back-reference from `Child` to `ParentProtocol` is a weak property to avoid a memory leak.

```swift
protocol ParentProtocol: AnyObject { }
protocol ChildProtocol: AnyObject { }

class Parent: ParentProtocol {
    let child: ChildProtocol?

    init(child: ChildProtocol?) {
        self.child = child
    }
}

class Child: ChildProtocol {
    weak var parent: ParentProtocol?
}
```

The circular dependencies are defined as below:

```swift
let container = Container()
container.register(ParentProtocol.self) { r in
    Parent(child: r.resolve(ChildProtocol.self)!)
}
container.register(ChildProtocol.self) { _ in Child() }
    .initCompleted { r, c in
        let child = c as! Child
        child.parent = r.resolve(ParentProtocol.self)
    }
```

Here the injection to the `parent` property of `Child` must be specified in the `initCompleted` callback to avoid infinite recursion.

## Property/Property Dependencies

Similarly, assume that you have the following classes depending on each other, each via a property:

```swift
protocol ParentProtocol: AnyObject { }
protocol ChildProtocol: AnyObject { }

class Parent: ParentProtocol {
    var child: ChildProtocol?
}

class Child: ChildProtocol {
    weak var parent: ParentProtocol?
}
```

The circular dependencies are defined as below:

```swift
let container = Container()
container.register(ParentProtocol.self) { r in
    let parent = Parent()
    parent.child = r.resolve(ChildProtocol.self)!
    return parent
}
container.register(ChildProtocol.self) { _ in Child() }
    .initCompleted { r, c in
        let child = c as! Child
        child.parent = r.resolve(ParentProtocol.self)
    }
```

Here both or either of the depending properties must be specified in the `initCompleted` callback to avoid infinite recursion.

## Initializer/Initializer Dependencies

_Not supported._ This type of dependency causes infinite recursion.

## Remark

When resolving circular dependencies one of the factory methods (one containing resolution of circular dependency) migth be invoked twice. Only one of the resulting instances will be used in the final object graph but in some cases this can be problematic - particularly when there are side effects of factory invocation, such as
- time consuming operations
- interactions with resolved dependencies
 
You can avoid duplicate invocation by resolving both parts of the dependency cycle inside `initCompleted` closures, for example refactoring
```swift
container.register(ParentProtocol.self) { r in
    let parent = Parent()
    parent.child = r.resolve(ChildProtocol.self)!
    return parent
}
```
to
```swift
container.register(ParentProtocol.self) { _ in Parent() } 
    .initCompleted { r, p in
        let parent = p as! Parent
        parent.child = r.resolve(ChildProtocol.self)!
    }
```

_[Next page: Object Scopes](ObjectScopes.md)_

_[Table of Contents](README.md)_
