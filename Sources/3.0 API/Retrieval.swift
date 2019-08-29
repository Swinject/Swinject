//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftformat:disable unusedArguments indent
// swiftlint:disable force_try

#if swift(>=5.1)
@propertyWrapper public struct Injected<Value> {
    private var value: Value?
    private let request: InstanceRequest<Value>

    public init(_ request: InstanceRequest<Value>) {
        self.request = request
    }

    public init() {
        request = instance()
    }

    public var wrappedValue: Value { fatalError() }

    public static subscript<EnclosingType: SwinjectAware>(
        _enclosingInstance enclosing: EnclosingType,
        wrapped wrappedKeyPath: KeyPath<EnclosingType, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingType, Self>
    ) -> Value {
        if let value = enclosing[keyPath: storageKeyPath].value {
            return value
        } else {
            let request = enclosing[keyPath: storageKeyPath].request
            let newValue = try! enclosing.swinject.resolve(request)
            enclosing[keyPath: storageKeyPath].value = newValue
            return newValue
        }
    }
}
#endif
