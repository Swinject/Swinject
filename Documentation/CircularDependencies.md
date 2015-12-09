# Circular Dependencies

Circular Dependencies are dependencies of instances that depend on each other. To define Circular Dependencies by Swinject, either of the dependencies must be injected through the property.

## Initializer/Property Dependencies

Assume that you have `Parent` and `Child` classes depending on each other. `Parent` depends on `ChildType` through its initializer, and `Child` on `ParentType` through its property. The back-reference from `Child` to `ParentType` is a weak property to avoid memory leak.

    protocol ParentType: AnyObject { }
    protocol ChildType: AnyObject { }

    class Parent: ParentType {
        let child: ChildType?

        init(child: ChildType?) {
            self.child = child
        }
    }

    class Child: ChildType {
        weak var parent: ParentType?
    }

The Circular Dependencies are defined as below.

    let container = Container()
    container.register(ParentType.self) { r in
        Parent(child: r.resolve(ChildType.self)!)
    }
    container.register(ChildType.self) { _ in Child() }
        .initCompleted { r, c in
            let child = c as! Child
            child.parent = r.resolve(ParentType.self)
        }

Here the injection to the `parent` property of `Child` must be specified in the `initCompleted` callback to get rid of infinite recursive calls.

## Property/Property Dependencies

Similarly, assume that you have the following classes depending through each property.

    protocol ParentType: AnyObject { }
    protocol ChildType: AnyObject { }

    class Parent: ParentType {
        var child: ChildType?
    }

    class Child: ChildType {
        weak var parent: ParentType?
    }

The Circular Dependencies are defined as below.

        let container = Container()
        container.register(ParentType.self) { r in
            let parent = Parent()
            parent.child = r.resolve(ChildType.self)!
            return parent
        }
        container.register(ChildType.self) { _ in Child() }
            .initCompleted { r, c in
                let child = c as! Child
                child.parent = r.resolve(ParentType.self)
            }

Here the both or either of the depending properties must be specified in the `initCompleted` callback to get rid of infinite recursive calls.

## Initializer/Initializer Dependencies

Not supported. This type of dependencies causes infinite recursive calls.

_[Next page: Object Scopes](ObjectScopes.md)_

_[Table of Contents](README.md)_
