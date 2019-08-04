//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@propertyWrapper public struct Weak<Value>: PropertyWrapper where Value: AnyObject {
    public weak var wrappedValue: Value?

    public init(wrappedValue: @autoclosure @escaping () -> Value) {
        self.wrappedValue = wrappedValue()
    }
}
