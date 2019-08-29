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

public class NoBinding: SwinjectError {}
public class MultipleBindings: SwinjectError {}
public class DuplicateModules: SwinjectError {}
public class OverrideNotAllowed: SwinjectError {}
public class NothingToOverride: SwinjectError {}
public class SilentOverrideNotAllowed: SwinjectError {}
public class NoContextTranslator: SwinjectError {}
public class CircularDependency: SwinjectError {}
public class MissingArgument: SwinjectError {}
public class ArgumentMismatch: SwinjectError {}
public class MissingDependency: SwinjectError {}

// TODO: Debugging error description
