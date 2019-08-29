//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

#if swift(>=5.1)
    @propertyWrapper public struct Weak<Value>: PropertyWrapper where Value: AnyObject {
        public weak var wrappedValue: Value?

        public init(wrappedValue: Value?) {
            self.wrappedValue = wrappedValue
        }
    }

#else
    public struct Weak<Value>: PropertyWrapper where Value: AnyObject {
        public weak var wrappedValue: Value?

        public init(wrappedValue: Value?) {
            self.wrappedValue = wrappedValue
        }
    }
#endif
