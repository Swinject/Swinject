# Circular Dependencies

Circular Dependencies are dependencies of instances that depend on each other. To define Circular Dependencies by Swinject, either of the dependencies must be injected through the property.

## Initializer/Property Dependencies

Assume that you have `Mother` and `Daughter` classes depending on each other. `Mother` depends on `ChildType` through its initializer, and `Daughter` on `ParentType` through its property. The back-reference from `Daughter` to `ParentType` is a weak property to avoid memory leak.

    protocol ParentType: AnyObject { }
    protocol ChildType: AnyObject { }

    class Mother: ParentType {
        let child: ChildType?

        init(child: ChildType?) {
            self.child = child
        }
    }

    class Daughter: ChildType {
        weak var parent: ParentType?
    }

The Circular Dependencies are defined as below.

    let container = Container()
    container.register(ParentType.self) { r in
        Mother(child: r.resolve(ChildType.self)!)
    }
    container.register(ChildType.self) { _ in Daughter() }
        .initCompleted { r, c in
            let daughter = c as! Daughter
            daughter.parent = r.resolve(ParentType.self)
        }

Here the injection to the `parent` property of `Daughter` must be specified in the `initCompleted` callback to get rid of infinite recursive calls.

## Property/Property Dependencies

Similarly, assume that you have the following classes depending through each property.

    protocol ParentType: AnyObject { }
    protocol ChildType: AnyObject { }

    class Mother: ParentType {
        var child: ChildType?
    }

    class Daughter: ChildType {
        weak var parent: ParentType?
    }

The Circular Dependencies are defined as below.

        let container = Container()
        container.register(ParentType.self) { r in
            let mother = Mother()
            mother.child = r.resolve(ChildType.self)!
            return mother
        }
        container.register(ChildType.self) { _ in Daughter() }
            .initCompleted { r, c in
                let daughter = c as! Daughter
                daughter.parent = r.resolve(ParentType.self)
            }

Here the both or either of the depending properties must be specified in the `initCompleted` callback to get rid of infinite recursive calls.

## Initializer/Initializer Dependencies

Not supported. This type of dependencies causes infinite recursive calls.

_[Next page: Container Hierarchy](ContainerHierarchy.md)_

_[Table of Contents](README.md)_
