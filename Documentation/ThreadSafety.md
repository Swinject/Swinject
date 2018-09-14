# Thread Safety

Swinject is designed to be used in concurrent applications. `Container` itself is not thread safe, but its `synchronize` method returns a thread safe view to the container as `Resolver` type.

```swift
let container = Container()
container.register(SomeType.self) { _ in SomeImplementation() }

let threadSafeContainer: Resolver = container.synchronize()

// Do something concurrently.
for _ in 0..<4 {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
        let resolvedInstance = threadSafeContainer.resolve(SomeType.self)
        // ...
    }
}
```

## Component Registrations

Since the thread safe view of a container is `Resolver` type, which has only overloads of `resolve` methods, registrations to the container are not thread safe. Registrations must be performed on a single thread, typically at the time when an app starts up.

## Service Resolutions

Only resolutions through the `Resolver` instance returned by `synchronize` method are thread safe. Calling `resolve` method directly on a `Container` instance is not thread safe.

If you have a container hierarchy (parent-child relationship of containers), all the containers must be accessed through the thread safe views when you resolve services.

```swift
let parentContainer = Container()
parentContainer.register(SomeType.self) { _ in SomeImplementation() }

let parentResolver = parentContainer.synchronize()
let childResolver = Container(parent: parentContainer).synchronize()

// Do something concurrently.
for _ in 0..<4 {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
        let instanceFromParent = parentResolver.resolve(SomeType.self)
        // ...
    }
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
        let instanceFromChild = childResolver.resolve(SomeType.self)
        // ...
    }
}
```

## SwinjectStoryboard

`SwinjectStoryboard` does not require the thread safe view of a container in most of the cases because instantiation of a view controller is normally performed on the main thread. Only if you use the same container in another thread, the synchronized view should be passed to `SwinjectStoryboard` when you create its instance and be used in the other thread too.

```swift
let threadSafeContainer: Resolver = Container() { container in
    container.registerForStoryboard(SomeViewController.self) { r, c in
        c.something = r.resolve(SomeType.self)
    }
    container.register(SomeType.self) { _ in SomeImplementation() }
}.synchronize()

let storyboard = SwinjectStoryboard.create(
    name: "Main",
    bundle: NSBundle.mainBundle(),
    container: threadSafeContainer)

// Do something on a background thread.
dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
    let something = threadSafeContainer.resolve(SomeType.self)
    // ...
}

// Instantiate a view controller on the main thread.
let viewController = storyboard.instantiateInitialViewController()
```

Refer to [Storyboard README](https://github.com/Swinject/SwinjectStoryboard) for more details about `SwinjectStoryboard` itself.

_[Table of Contents](README.md)_
