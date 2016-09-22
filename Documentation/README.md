# Documentation

This is documentation for Swinject v2.x series. Documentation for v1.x is [here](https://github.com/Swinject/Swinject/tree/v1/Documentation).

Swinject is a lightweight dependency injection framework for Swift apps. It allows you to split your app into loosely-coupled components, which can then be maintained and tested more easily. Swinject <a name="pure-swift-type-support">supports pure Swift types</a>, and is powered by the Swift generic type system and [first class functions](https://en.wikipedia.org/wiki/First-class_function). This makes it syntactically elegant and simple to define the object dependencies for your app.

## Table of Contents

### Basics

1. [DI Container](DIContainer.md)
2. [Injection Patterns](InjectionPatterns.md)
3. [Circular Dependencies](CircularDependencies.md)
4. [Object Scopes](ObjectScopes.md)
5. [Misc](Misc.md)

### Advanced Features

1. [Container Hierarchy](ContainerHierarchy.md)
2. [Modularizing Service Registration (Assembly)](Assembler.md)
3. [Thread Safety](ThreadSafety.md)

### Extensions

1. [SwinjectPropertyLoader](https://github.com/Swinject/SwinjectPropertyLoader): Loading property values from resources
2. [SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard): Automatic dependency injection via Storyboard
3. [Swinject-CodeGen](https://github.com/Swinject/Swinject-CodeGen): Type-safe code generation of `Container` from a CSV/YAML file defining dependencies
