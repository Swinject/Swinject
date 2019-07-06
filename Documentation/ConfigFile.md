# ConfigFile

Example:

Config File:
```json
{
    "definitions": [
        {
            "identifier": "Car",
            "type": "Projectname.Car",
            "arguments": [
                {
                "value": "driver",
                "identifier": "Driver"
                }
            ]
        },
        {
            "identifier": "Driver",
            "type": "Projectname.Driver",
            "arguments": []
        }
    ]
}
```

Swift Code for Classes:
```swift
public class Car : NSObject {
    public var driver: Driver?

    @objc public func setDriver(_ driver: NSObject){
        self.driver = driver as? Driver
    }
}

public class Driver : NSObject {
    public var name: String

    public override init() {
        name = "Driver"
    }
}
```

Note that you have to define a setter for each argument defined in the JSON.
The setter start with a lower-cased set followed by the name defined in the JSON. The Name allways starts upper-cased.
Also all classes have to inherit from NSObject and the setters have to be signed with @objc.

To register the Json use the following Code:
```swift
let url = URL("ConfigFile.json")

try container.registerConfig(url!)
```
After that, you are able to use the Container as usual.


You have trouble to get the correct name of a class?
Use the followin Code:
```swift
let name = NSStringFromClass(unknownClass.self)
print(name)
```

