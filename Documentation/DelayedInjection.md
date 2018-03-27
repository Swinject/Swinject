# Delayed Injection

There are cases when - for various reasons - you don't want dependencies to be created immediately when the object is resolved from the `Container`, but only when they are needed. Swinject provides two ways of delayed injection: **Lazy** and **Provider**:

- **Lazy** dependency behaves similarly to Swift's `lazy` variables: it is created first time it is accessed, and remembers that same value for all subsequent calls.
- **Provider** dependency behaves similarly to Swift's computed variables: new instance is created every time it is accessed.

Differences between lazy, provider and direct injection can be demonstrated with an example. Consider this registration for `Int`:

```swift
var value = 0;
container.register(Int.self) { _ in 
    value += 1;
    print("creating Int")
    return value;
}
```


### Direct injection

```swift
struct DirectCounter {
    let integer: Int

    func print() {
        print("printing")
        print(integer)
        print(integer)
        print(integer)
    }
}

container.register(DirectCounter.self) { DirectCounter(integer: $0.resolve(Int.self)!) }

let counter = container.resolve(DirectCounter.self)!
counter.print()
```

Output of the above code would be

```
creating Int
printing
1
1
1
```

### Lazy Injection

```swift
struct LazyCounter {
    let integer: Lazy<Int>

    func print() {
        print("printing")
        print(integer)
        print(integer)
        print(integer)
    }
}

container.register(LazyCounter.self) { LazyCounter(integer: $0.resolve(Lazy<Int>.self)!) }

let counter = container.resolve(LazyCounter.self)!
counter.print()
```

Output of the above code would be

```
printing
creating Int
1
1
1
```

### Provider Injection

```swift
struct ProviderCounter {
    let integer: Provider<Int>

    func print() {
        print("printing")
        print(integer)
        print(integer)
        print(integer)
    }
}

container.register(ProviderCounter.self) { ProviderCounter(integer: $0.resolve(Provider<Int>.self)!) }

let counter = container.resolve(ProviderCounter.self)!
counter.print()
```

Output of the above code would be

```
printing
creating Int
1
creating Int
2
creating Int
3
```
