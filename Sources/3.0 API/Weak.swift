//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

#if swift(>=5.1)
    @propertyWrapper public struct Weak<Value>: PropertyWrapper where Value: AnyObject {
        public weak var wrappedValue: Value?

        public init(initialValue: @autoclosure () -> Value?) {
            wrappedValue = initialValue()
        }
    }

#else
    public struct Weak<Value>: PropertyWrapper where Value: AnyObject {
        public weak var wrappedValue: Value?

        public init(initialValue: @autoclosure () -> Value?) {
            wrappedValue = initialValue()
        }
    }
#endif
