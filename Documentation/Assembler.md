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

## SmartAssembly

A `SmartAssembly` is a special type of `Assembly` that **declares explicit dependencies** on other assemblies.  

Unlike a regular `Assembly`, which relies on the user to manually provide all required assemblies to an `Assembler`, a `SmartAssembly` allows the assembler to **automatically manage dependencies**, making your assembly graphs safer and more maintainable.

### Key Features

- **Explicit dependencies:** Declare other assemblies your assembly requires.
- **Automatic instantiation:** Missing SmartAssemblies can be auto-created in Smart Mode.
- **Validation:** The assembler can detect missing required assemblies and circular dependencies.
- **Compatibility:** SmartAssemblies can depend on classic assemblies, but classic assemblies are **not auto-initialized**.

### Declaration

To define a SmartAssembly, implement the `SmartAssembly` protocol:

```swift
final class NetworkingAssembly: SmartAssembly {
    // List required assemblies
    static var requiredAssemblies: [SmartAssembly.Type] {
        [CoreAssembly.self]
    }

    // Default initializer required for auto-instantiation
    required init() {}

    func assemble(container: Container) {
        // register networking services
    }
}
```

- The `requiredAssemblies` array specifies dependencies.
- Dependencies are resolved recursively by the assembler.
- The order in the array **does not affect assembly order**; the assembler automatically applies dependencies first.

### Behavior in Smart Mode

- **Auto-initialization:** Assemblies in `requiredAssemblies` are automatically created if missing and `initializeMissingAssemblies` is true.
- **Validation errors:** If `initializeMissingAssemblies` is false and required assemblies are missing, the assembler throws a `missingRequiredAssemblies` error.
- **Circular dependency detection:** If assemblies depend on each other in a cycle, a `circularDependency` error is thrown.

### Example Usage

```swift
let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
assembler.apply(assembly: NetworkingAssembly()) 
```

- If `CoreAssembly` is missing, it will be automatically applied.
- If any circular dependencies exist, assembly will fail.

### Notes

- SmartAssemblies **must have a default initializer** (`init()`) for automatic instantiation.
- Classic assemblies can be dependencies but are **never auto-initialized**; they must be applied manually.
- SmartAssemblies enable building **dependency-aware assembly graphs** with less manual management and safer runtime behavior.

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

### Smart Mode (Dependency-Aware Assemblies)

The `Assembler` now supports **Smart Mode**, which provides dependency-aware assembly behavior.

- Assemblies conforming to `SmartAssembly` can declare required dependencies via `requiredAssemblies`.
- In Smart Mode, missing SmartAssemblies can be automatically instantiated.
- Classic assemblies are **not auto-initialized** and must be applied manually.
- Circular dependencies are detected and prevent assembly.

#### Auto-Initialization of Missing SmartAssemblies

```swift
let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
assembler.apply(assembly: DependentAssembly()) // Automatically applies BaseAssembly
let result = assembler.resolver.resolve(Int.self) // 42
```

- `initializeMissingAssemblies = true` → missing SmartAssemblies are automatically instantiated.
- `initializeMissingAssemblies = false` → missing SmartAssemblies throw an error:

```swift
let assembler = Assembler(mode: .smart(initializeMissingAssemblies: false))
assembler.apply(assembly: DependentAssembly()) // Throws if BaseAssembly is missing
```

#### Circular Dependency Detection

```swift
assembler.apply(assembly: CircularA()) // Throws circularDependency error if CircularB requires CircularA
```

#### SmartAssemblies Depending on Classic Assemblies

- SmartAssemblies **can depend on classic assemblies**, but the assembler will **not auto-initialize classic assemblies**.
- You must manually apply classic assemblies before or after:

```swift
assembler.apply(assembly: ClassicOnlyAssembly())   // Apply classic assembly
assembler.apply(assembly: DependsOnClassic())     // SmartAssembly depending on classic
```

#### Multi-Level Dependencies

- SmartAssemblies can depend on other SmartAssemblies recursively.
- Missing assemblies are resolved **before dependent assemblies** are applied:

```swift
assembler.apply(assembly: MultiLevelA())
assembler.resolver.resolve(String.self)  // "A"
assembler.resolver.resolve(Int.self)     // 99
assembler.resolver.resolve(Double.self)  // 3.14
```

#### Lazy Loading with Smart Mode

- Smart assemblies can be applied lazily using `apply(assembly:)` or `apply(assemblies:)`.
- Dependencies are resolved at the time of application.

```swift
let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
assembler.apply(assembly: DependentAssembly())
assembler.apply(assemblies: [ClassicOnlyAssembly()])
```

#### Child Assemblers in Smart Mode

- Child assemblers can use Smart Mode independently of the parent.
- Registrations in a child **do not propagate to the parent**.

```swift
let parent = Assembler(mode: .classic)
let child = Assembler(parentAssembler: parent, mode: .smart(initializeMissingAssemblies: true))
child.apply(assembly: DependentAssembly())
child.resolver.resolve(Int.self)   // 42
parent.resolver.resolve(Int.self)  // nil
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
