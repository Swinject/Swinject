## Description

This PR adds a new `multiton` object scope to Swinject that caches instances based on the arguments used during resolution. When resolving with the same arguments, the same instance is returned.

## Example

```swift
container.register(Animal.self) { _, name in
    Cat(name: name)
}
.inObjectScope(.multiton)

let cat1 = container.resolve(Animal.self, argument: "Mimi")
let cat2 = container.resolve(Animal.self, argument: "Mimi") // Same instance as cat1
let cat3 = container.resolve(Animal.self, argument: "Mew")  // Different instance
```

## Key Features

- ✅ Caches instances by their initialization arguments
- ✅ Supports up to 9 arguments (matching Swinject's existing limit)
- ✅ Works with `resetObjectScope(.multiton)` to clear cached instances
- ✅ Fully backward compatible - no breaking changes
- ✅ Thread-safe implementation
- ✅ Comprehensive test coverage

## Requirements

- Arguments must be `Hashable` for caching to work
- Non-hashable arguments will result in no caching (new instance each time)

## Files Changed

- **Added**: `MultitonStorage` class and multiton scope definition
- **Modified**: Container resolution logic to support argument-based caching
- **Extended**: `InstanceStorage` protocol with backward-compatible default implementations
- **Documentation**: Added examples and explanations in ObjectScopes.md
- **Tests**: New test file `ContainerTests.Multiton.swift` with comprehensive coverage

## Use Cases

- Configuration-based singletons (e.g., database connections per connection string)
- Locale-specific formatters or resources
- User-specific service instances in multi-tenant applications
- Any scenario where you want to reuse instances based on initialization parameters

Fixes #[issue_number] (if applicable) 