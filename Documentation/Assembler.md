# Modularizing Service Registration
This feature provides your implementation the ability to group related service definitions together
in an `AssemblyType`. This allows your application to:

   - keep things organized by keeping like services in 1 place
   - provided a shared `Container`
   - allows registering different assembly configurations which is useful for swapping out mock implementations
   - can be "load aware" when the container is fully configured

This feature is an opinionated way to how your can register services in your `Container`. There are
parts to this feature:

## AssemblyType
The `AssemblyType` is a protocol that is provided a shared `Container` where service definitions 
can be registered. The shared `Container` will contain **all** service definitions from every
`AssemblyType` registered to the `Assembler`. Let's look at an example:

    class ServiceAssembly: AssemblyType {
        func assemble(container: Container) {
            container.register(FooServiceType.self) { r in 
               return FooService()
            }
            container.register(BarServiceType.self) { r in 
               return BarService()
            }
        }
    }

    class ManagerAssembly: AssemblyType {
        func assemble(container: Container) {
            container.register(FooManagerType.self) { r in 
               return FooManager(service: r.resolve(FooServiceType.self)!)
            }
            container.register(BarManagerType.self) { r in 
               return BarManager(service: r.resolve(BarServiceType.self)!)
            }
        }
    }

Here we have created 2 assemblies: 1 for services and 1 for managers. As you can see the `ManagerAssembly`
leverages service definitions registered in the `ServiceAssembly`. Using this pattern the `ManagerAssembly`
doesn't care where the `FooServiceType` and `BarServiceType` are registered, it just requires them to
be registered else where.

### Load aware
The `AssemblyType` allows the assembly to be aware when the container has been fully loaded
by the `Assembler`. 

Let's imagine you have an simple Logger class that can be configured with different log handlers:
    
    protocol LogHandlerType {
        func log(message: String)
    }

    class Logger {
         
         class var sharedInstance: Logger!

         var logHandlers = [LogHandlerType]()
        
         func addHandler(logHandler: LogHandlerType) {
            logHandlers.append(logHandler)
         }

         func log(message: String) {
            for logHandler in logHandlers {
               logHandler.log(message)
            }
         }
    }

This singleton is accessed in global logging functions to make it easy to add logging anywhere
without having to deal with injects:

     func logDebug(message: String) {
         Logger.sharedInstance.log("DEBUG: \(message")
     } 

In order to configure the `Logger` shared instance in the container we will need to resolve the
`Logger` after the `Container` has been built. Using a `AssemblyType` you can keep this
bootstrapping in the assembly:

     class LoggerAssembly: AssemblyType {
         func assemble(container: Container) {
            container.register(LogHandlerType.self, name: "console") { r in 
               return ConsoleLogHandler()
            }
            container.register(LogHandlerType.self, name: "file") { r in 
               return FileLogHandler()
            }
        }

        func loaded(resolver: ResolverType) {
            Logger.sharedInstance.addHandler(
               resolver.resolve(LogHandlerType.self, name: "console")!)
            Logger.sharedInstance.addHandler(
               resolver.resolve(LogHandlerType.self, name: "file")!)
        }
     }

## Assembler
The `Assembler` is responsible for managing the `AssemblyType` instances and the `Container`. Using
the `Assembler` the `Container` is only exposed to assemblies registered with the assembler and
only provides your application access via the `ResolverType` protocol which limits registration
access strictly to the assemblies.

Using the `ServiceAssembly` and `ManagerAssembly` above we can create our assembler:

    let assembler = try! Assembler(assemblies: [
        ServiceAssembly(),
        ManagerAssembly()  
    ])

Now you can resolve any components from either assembly:

    let fooManager = assembler.resolver.resolve(FooManagerType.self)!

You can also lazy load assemblies:

     assembler.applyAssembly(LoggerAssembly())

The assembler also supports managing your property files as well via construction or lazy loading:

     let assembler = try! Assembler(assemblies: [
          ServiceAssembly(),
          ManagerAssembly()  
      ], propertyLoaders: [
          JsonPropertyLoader(bundle: .mainBundle(), name: "properties")
      ])

      // or lazy load them
      assembler.applyPropertyLoader(
         JsonPropertyLoader(bundle: .mainBundle(), name: "properties"))



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
