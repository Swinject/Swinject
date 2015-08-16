# Storyboard

Swinject supports dependency injection to view controllers instantiated by `SwinjectStoryboard`, which inherits `UIStoryboard` (or `NSStoryboard` for OS X). To register dependencies of a view controller, use `registerForStoryboard` method. In the same way as a registration of a service type, a view controller can be registered with or without a name.

## Registration without Name

Here is an example to simply register a dependency of a view controller without a registration name.

    let container = Container()
    container.registerForStoryboard(AnimalViewController.self) { r, c in
        c.animal = r.resolve(AnimalType.self)
    }
    container.register(AnimalType.self) { _ in Cat(name: "Mimi") }

Then create an instance of `SwinjectStoryboard` with the container specified. If the container is not specified, `Container.defaultContainer` is used instead. `instantiateViewControllerWithIdentifier` method creates an instance of the view controller with its dependencies injected:

    let sb = SwinjectStoryboard.create(
        name: "Animals", bundle: nil, container: container)
    let controller = sb.instantiateViewControllerWithIdentifier("Animal")
        as! AnimalViewController
    print(controller.animal! is Cat) // prints "true"
    print(controller.animal!.name) // prints "Mimi"

Where the classes and protocol are:

    class AnimalViewController: UIViewController {
        var animal: AnimalType?

        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

    protocol AnimalType {
        var name: String { get set }
    }

    class Cat: AnimalType {
        var name: String

        init(name: String) {
            self.name = name
        }
    }

and the storyboard named `Animals.storyboard` has `AnimalViewController` with storyboard ID `Animal`.

![AnimalViewController in Animals.storyboard](./Assets/AnimalViewControllerScreenshot1.png)

## Registration with Name

If a storyboard has more than a view controller with the same type, dependencies should be registered with registration names.

    let container = Container()
    container.registerForStoryboard(AnimalViewController.self, name: "cat") {
        r, c in c.animal = r.resolve(AnimalType.self, name: "mimi")
    }
    container.registerForStoryboard(AnimalViewController.self, name: "dog") {
        r, c in c.animal = r.resolve(AnimalType.self, name: "hachi")
    }
    container.register(AnimalType.self, name: "mimi") {
        _ in Cat(name: "Mimi")
    }
    container.register(AnimalType.self, name: "hachi") {
        _ in Dog(name: "Hachi")
    }

Then view controllers are instantiated with storyboard IDs similarly to the case without registration names.

    let sb = SwinjectStoryboard.create(
        name: "Animals", bundle: nil, container: container)
    let catController = sb.instantiateViewControllerWithIdentifier("Cat")
        as! AnimalViewController
    let dogController = sb.instantiateViewControllerWithIdentifier("Dog")
        as! AnimalViewController
    print(catController.animal!.name) // prints "Mimi"
    print(dogController.animal!.name) // prints "Hachi"

Where `Dog` class is:

    class Dog: AnimalType {
        var name: String

        init(name: String) {
            self.name = name
        }
    }

and the storyboard named `Animals.storyboard` has `AnimalViewController`s with storyboard IDs `Cat` and `Dog`. In addition to the storyboard IDs, user defined runtime attributes are specified as `cat` and `dog` for the key `swinjectRegistrationName`, respectively.

![AnimalViewControllers with user defined runtime attribute in Animals.storyboard](./Assets/AnimalViewControllerScreenshot2.png)

_[Table of Contents](README.md)_
