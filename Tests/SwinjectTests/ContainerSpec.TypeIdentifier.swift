//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ContainerSpec_TypeIdentifier: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        it("describes a registration with dedicated identifier.") {
            container.register(Animal.self, identifier: AnimalIdentifier.myCat) { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Name: \"\(AnimalIdentifier.myCat.rawValue)\", Factory: Resolver -> Animal, ObjectScope: graph }\n"
                + "]"
        }
        it("describes a registration with dedicated identifier and arguments.") {
            container.register(Animal.self, identifier: AnimalIdentifier.myCat) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Name: \"\(AnimalIdentifier.myCat.rawValue)\", Factory: (Resolver, String, Bool) -> Animal, ObjectScope: graph }\n"
                + "]"
        }
        it("describes multiple registrations with dedicated identifiers.") {
            container.register(Animal.self, identifier: AnimalIdentifier.myCat) { _ in Cat() }
            container.register(Animal.self, identifier: AnimalIdentifier.myOtherCat) { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Animal, Name: \"\(AnimalIdentifier.myCat.rawValue)\", Factory: Resolver -> Animal, ObjectScope: graph },\n"
                + "    { Service: Animal, Name: \"\(AnimalIdentifier.myOtherCat.rawValue)\", Factory: Resolver -> Animal, ObjectScope: graph }\n"
                + "]"
        }

        it("describes a registration with type identifier.") {
            container.register(Cat.self, identifier: .firstCat) { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Cat, Name: \"\(Cat.SwinjectName.firstCat.rawValue)\", Factory: Resolver -> Cat, ObjectScope: graph }\n"
                + "]"
        }
        it("describes a registration with type identifier and arguments.") {
            container.register(Cat.self, identifier: .firstCat) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }

            expect(container.description) ==
                "[\n"
                + "    { Service: Cat, Name: \"\(Cat.SwinjectName.firstCat.rawValue)\", Factory: (Resolver, String, Bool) -> Cat, ObjectScope: graph }\n"
                + "]"
        }
        it("describes multiple registrations with type identifiers.") {
            container.register(Cat.self, identifier: .firstCat) { _ in Cat() }
            container.register(Cat.self, identifier: .secondCat) { _ in Cat() }

            expect(container.description) ==
                "[\n"
                + "    { Service: Cat, Name: \"\(Cat.SwinjectName.firstCat.rawValue)\", Factory: Resolver -> Cat, ObjectScope: graph },\n"
                + "    { Service: Cat, Name: \"\(Cat.SwinjectName.secondCat.rawValue)\", Factory: Resolver -> Cat, ObjectScope: graph }\n"
                + "]"
        }
    }
}
