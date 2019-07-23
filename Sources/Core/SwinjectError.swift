//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public class SwinjectError: Error {
    let file: String
    let line: Int

    init(file: String = #file, line: Int = #line) {
        self.file = file
        self.line = line
    }
}

public class NoBindingError: SwinjectError {}
public class MultipleBindingsError: SwinjectError {}

// TODO: Debugging error description
