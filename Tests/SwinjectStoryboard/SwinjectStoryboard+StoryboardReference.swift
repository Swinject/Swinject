//
//  SwinjectStoryboard+StoryboardReference.
//  SwinjectStoryboard
//
//  Created by Jakub Vaňo on 01/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

internal extension SwinjectStoryboard {

    static func pushInstantiatingStoryboard(storyboard: SwinjectStoryboard) {
        storyboardStack.append(storyboard)
    }

    static func popInstantiatingStoryboard() -> SwinjectStoryboard? {
        return storyboardStack.popLast()
    }

    static var isCreatingStoryboardReference: Bool {
        return referencingStoryboard != nil
    }

    static var referencingStoryboard: SwinjectStoryboard? {
        return storyboardStack.last
    }

    static func createReferenced(name name: String, bundle storyboardBundleOrNil: NSBundle?) -> SwinjectStoryboard {
        if let container = referencingStoryboard?.container.value {
            return create(name: name, bundle: storyboardBundleOrNil, container: container)
        } else {
            return create(name: name, bundle: storyboardBundleOrNil)
        }
    }
}

private var storyboardStack = [SwinjectStoryboard]()
