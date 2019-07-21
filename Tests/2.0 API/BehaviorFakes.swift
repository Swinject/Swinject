//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class BehaviorSpy: Behavior {
    var entries = [ServiceEntryProtocol]()
    var names = [String?]()
    var types = [Any.Type]()

    func container<Type, Service>(
        _: Container,
        didRegisterType type: Type.Type,
        toService entry: ServiceEntry<Service>,
        withName name: String?
    ) {
        entries.append(entry)
        names.append(name)
        types.append(type)
    }
}
