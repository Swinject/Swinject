//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SwinjectError: Error {
    let file: String
    let line: Int

    init(file: String = #file, line: Int = #line) {
        self.file = file
        self.line = line
    }
}

// TODO: Debugging error description
