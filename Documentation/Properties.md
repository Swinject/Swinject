# Properties
Properties can be loaded from resources that are bundled with your application/framework.
These properties can be used when assembling definitions in your container. There
are 2 types of support property formats:

 - JSON (`JsonPropertyLoader`)
 - Plist (`PlistPropertyLoader`)

Each format supports the types specified by the format itself. If JSON format is used
then your basic types: `Bool`, `Int`, `Double`, `String`, `Array` and `Dictionary` are
supported. For Plist, all types supported by the Plist are supported which include all
JSON types plus `NSDate` and `NSData`.

JSON property files also support comments which allow you to provide more context to
your properties besides your property key names. For example:

    {
        // Comment type 1
        "foo": "bar",

        /* Comment type 2 */
        "baz": 100,

        /**
         Comment type 3
         */
        "boo": 30.50
    }

Loading properties into the container is as simple as:

    let container = Container()

    // will load "properties.json" from the main app bundle
    let loader = JsonPropertyLoader(bundle: .mainBundle(), name: "properties")

    try! container.applyPropertyLoader(loader)

Now you can inject properties into definitions registered into the container. 
Consider the following definition:

    class Person {
        var name: String!
        var count: Int?
        var team: String = ""
    }

And let's say our `properties.json` file contains:

    {
        "name": "Mike",
        "count": 100,
        "team": "Giants"
    }

Then we can register this Service type with properties like so:

     container.register(Person.self) { r in
         let person = Person()
         person.name = r.property("name")
         person.count = r.property("count")
         person.team = r.property("team")!
     }

This will resolve the person as:

     let person = container.resolve(Person.self)!
     person.name // "Mike"
     person.count // 100
     person.team // "Giants"
   
Properties are available on a per-container basis. Multiple property loaders can be
applied to a single container. Properties are merged in the order in which they
are applied to a container. For example, let's say you have 2 property files:

    {
        "message": "hello from A",
        "count": 10
    }

And:

    {
        "message": "hello from B",
        "timeout": 4
    }

If we apply property file A, then property file B to the container, the resulting 
property key-value pairs would be:

    message = "hello from B"
    count = 10
    timeout = 4

As you can see the `message` property was overridden. This only works for first-level
properties which means `Dictionary` and `Array` are not merged. For example:

    {
        "items": [
            "hello from A"
        ]
    }

And:

    {
         "items": [
            "hello from B"
         ]
    }

The resulting value for `items` would be: `[ "hello from B" ]`

_[Next page: Modularizing Service Registration](Assembler.md)_

_[Table of Contents](README.md)_
