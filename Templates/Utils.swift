//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

func join(separator: String = ", ", _ strings: String? ...) -> String {
    return join(separator: separator, strings)
}

func join(separator: String = ", ", _ strings: [String?]) -> String {
    return strings.compactMap { $0 }.joined(separator: separator)
}
