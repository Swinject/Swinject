# Modularizing Service Registration

This feature provides your implementation the ability to group related service definitions together
in an `Assembly`. This allows your application to:

   - Keep things organized by keeping like services in one place.
   - Provide a shared `Container`.
   - Allow registering different assembly configurations, which is useful for swapping in mock implementations.
   - To be notified when the container is fully configured.

This feature is an opinionated way to how your can register services in your `Container` and using it is not required.

There are several parts to this feature.

## Assembly

The `Assembly` is a protocol that is provided a shared `Container` where service definitions
can be registered. The shared `Container` will contain **all** service definitions from every
`Assembly` registered to the `Assembler`. Let's look at an example:

```swift
class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FooServiceProtocol.self) { r in
           return FooService()
        }
        container.register(BarServiceProtocol.self) { r in
           return BarService()
        }
    }
}

class ManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FooManagerProtocol.self) { r in
           return FooManager(service: r.resolve(FooServiceProtocol.self)!)
        }
        container.register(BarManagerProtocol.self) { r in
           return BarManager(service: r.resolve(BarServiceProtocol.self)!)
        }
    }
}
```

Here we have created 2 assemblies: 1 for services and 1 for managers. As you can see the `ManagerAssembly`
leverages service definitions registered in the `ServiceAssembly`. Using this pattern the `ManagerAssembly`
doesn't care where the `FooServiceProtocol` and `BarServiceProtocol` are registered, it just requires them to
be registered else where.

### Load aware

The `Assembly` allows the assembly to be aware when the container has been fully loaded
by the `Assembler`.

Let's imagine you have an simple Logger class that can be configured with different log handlers:

```swift
protocol LogHandler {
    func log(message: String)
}

class Logger {

    static let sharedInstance = Logger()
    
    private init() {}

    var logHandlers = [LogHandler]()

    func addHandler(logHandler: LogHandler) {
        logHandlers.append(logHandler)
    }

    func log(message: String) {
        for logHandler in logHandlers {
            logHandler.log(message)
        }
    }
}
```

This singleton is accessed in global logging functions to make it easy to add logging anywhere
without having to deal with injects:

```swift
func logDebug(message: String) {
    Logger.sharedInstance.log("DEBUG: \(message)")
}
```

In order to configure the `Logger` shared instance in the container we will need to resolve the
`Logger` after the `Container` has been built. Using a `Assembly` you can keep this
bootstrapping in the assembly:

```swift
class LoggerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LogHandler.self, name: "console") { r in
            return ConsoleLogHandler()
        }
        container.register(LogHandler.self, name: "file") { r in
            return FileLogHandler()
        }
    }

    func loaded(resolver: Resolver) {
        Logger.sharedInstance.addHandler(
            resolver.resolve(LogHandler.self, name: "console")!)
        Logger.sharedInstance.addHandler(
            resolver.resolve(LogHandler.self, name: "file")!)
    }
}
```

## Assembler

The `Assembler` is responsible for managing the `Assembly` instances and the `Container`. Using
the `Assembler`, the `Container` is only exposed to assemblies registered with the assembler and
only provides your application access via the `Resolver` protocol which limits registration
access strictly to the assemblies.

Using the `ServiceAssembly` and `ManagerAssembly` above we can create our assembler:

```swift
let assembler = Assembler([
    ServiceAssembly(),
    ManagerAssembly()
])
```

Now you can resolve any components from either assembly:

```swift
let fooManager = assembler.resolver.resolve(FooManagerProtocol.self)!
```

You can also lazy load assemblies:

```swift
assembler.applyAssembly(LoggerAssembly())
```

The assembler also supports managing your property files as well via construction or lazy loading:

```swift
let assembler = Assembler([
        ServiceAssembly(),
        ManagerAssembly()
    ], propertyLoaders: [
        JsonPropertyLoader(bundle: .mainBundle(), name: "properties")
    ])

  // or lazy load them
assembler.applyPropertyLoader(
    JsonPropertyLoader(bundle: .mainBundle(), name: "properties"))
```

## IMPORTANT:

 - You **MUST** hold a strong reference to the `Assembler` otherwise the `Container`
   will be deallocated along with your assembler

 - If you are lazy loading your properties and assemblies you must load your properties **first** if
   you want your properties to be available to load aware assemblies when `loaded` is called

 - If you are lazy loading assemblies and you want your load aware assemblies to be invoked after
   all assemblies have been loaded then you must use `addAssemblies` and pass all lazy loaded assemblies
   at once

_[Next page: Thread Safety](ThreadSafety.md)_

_[Table of Contents](README.md)_
