//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

class Person {
    var age = 0
    var height = 0.0
    var name = ""
}

struct Pet {
    let owner: Person
}

struct TestError: Error, Equatable {}
