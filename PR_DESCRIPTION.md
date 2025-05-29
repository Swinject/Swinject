# Add Multiton Object Scope to Swinject

## Summary

This PR introduces a new object scope called `multiton` to Swinject. The multiton scope caches instances based on the arguments passed during resolution, allowing the same instance to be returned when resolving with identical arguments.

## Motivation

The multiton pattern is useful in scenarios where you want to:
- Share instances based on configuration parameters
- Implement a factory pattern where instances are cached by their initialization arguments
- Reduce memory usage and initialization overhead for objects that are expensive to create
- Maintain consistency when the same configuration should always yield the same instance

## Changes

### Added

1. **New Object Scope: `.multiton`**
   - Added `MultitonStorage` class in `Sources/InstanceStorage.swift`
   - Registered the scope in `Sources/ObjectScope.Standard.swift`
   - Instances are cached using arguments as keys

2. **Extended `InstanceStorage` Protocol**
   - Added new methods with default implementations for backward compatibility:
     - `func instance(inGraph:withArguments:) -> Any?`
     - `func setInstance(_:inGraph:withArguments:)`

3. **Container Resolution Enhancement**
   - Added `resolveWithArgumentCapture` method to extract and pass arguments to multiton storage
   - Modified resolution logic to handle multiton scope specially
   - Added support for argument extraction from tuples up to 9 arguments

4. **Documentation**
   - Added multiton scope documentation in `Documentation/ObjectScopes.md`
   - Updated `README.md` to include multiton in the feature list

5. **Tests**
   - Added comprehensive test suite in `Tests/SwinjectTests/ContainerTests.Multiton.swift`
   - Tests cover single arguments, multiple arguments, no arguments, and `resetObjectScope`

### Modified

1. **Container.swift**
   - Updated `_resolve` method to detect multiton storage and use argument capture
   - Modified `resolveAsWrapper` to support multiton scope for wrapped types
   - Updated `resolve` method to pass arguments to storage methods

2. **InstanceStorage.swift**
   - Added default implementations to maintain backward compatibility

## Usage

```swift
// Register a service with multiton scope
container.register(Animal.self) { _, name in
    Cat(name: name)
}
.inObjectScope(.multiton)

// Resolve with arguments
let cat1 = container.resolve(Animal.self, argument: "Mimi")
let cat2 = container.resolve(Animal.self, argument: "Mimi")
let cat3 = container.resolve(Animal.self, argument: "Mew")

// cat1 === cat2 (same instance for same arguments)
// cat1 !== cat3 (different instance for different arguments)
```

## Important Notes

- **Arguments must be `Hashable`**: The multiton scope requires arguments to be hashable to use them as cache keys
- **Memory considerations**: Cached instances are held strongly until `resetObjectScope(.multiton)` is called
- **Thread safety**: The implementation maintains the same thread safety guarantees as other Swinject scopes

## Implementation Details

The multiton storage uses a dictionary to cache instances by their arguments. When arguments are provided during resolution:

1. Arguments are extracted from the resolver's tuple format
2. Arguments are converted to a hashable representation
3. The cache is checked for an existing instance with those arguments
4. If found, the cached instance is returned; otherwise, a new instance is created and cached

For cases with no arguments, a special sentinel value is used as the cache key.

## Testing

The implementation includes comprehensive tests covering:
- Single argument caching
- Multiple argument caching  
- No argument scenarios
- Scope reset functionality
- Integration with existing Swinject features

## Breaking Changes

None. The implementation maintains full backward compatibility through default protocol implementations.

## Performance Impact

Minimal. The multiton scope adds a small overhead for:
- Argument extraction (only for multiton-scoped services)
- Hash computation for cache keys
- Dictionary lookup for cached instances

This overhead is negligible compared to the potential savings from reusing instances. 