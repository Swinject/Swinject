//
//  SynchronizedContainerSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class SynchronizedResolverSpec: QuickSpec {
    override func spec() {
        describe("Multiple threads") {
            it("can resolve circular dependencies.") {
                let container = Container() { container in
                    container.register(ParentType.self) { _ in Parent() }
                        .initCompleted { r, s in
                            let parent = s as! Parent
                            parent.child = r.resolve(ChildType.self)
                        }
                        .inObjectScope(.Graph)
                    container.register(ChildType.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentType.self)!
                        }
                        .inObjectScope(.Graph)
                }.synchronize()
                
                waitUntil(timeout: 2.0) { done in
                    let queue = dispatch_queue_create("SwinjectTests.SynchronizedContainerSpec.Queue", DISPATCH_QUEUE_CONCURRENT)
                    let totalThreads = 500 // 500 threads are enough to get fail unless the container is thread safe.
                    let counter = Counter()
                    for _ in 0..<totalThreads {
                        dispatch_async(queue) {
                            let parent = container.resolve(ParentType.self) as! Parent
                            let child = parent.child as! Child
                            expect(child.parent as? Parent) === parent
                            
                            counter.increment()
                            if counter.count >= totalThreads {
                                done()
                            }
                        }
                    }
                }
            }
            it("can access parent and child containers without dead lock.") {
                let runInObjectScope = { (scope: ObjectScope) in
                    let parentContainer = Container() { container in
                        container.register(AnimalType.self) { _ in Cat() }
                            .inObjectScope(scope)
                    }
                    let parentResolver = parentContainer.synchronize()
                    let childResolver = Container(parent: parentContainer).synchronize()
                    
                    waitUntil(timeout: 2.0) { done in
                        let queue = dispatch_queue_create("SwinjectTests.SynchronizedContainerSpec.Queue", DISPATCH_QUEUE_CONCURRENT)
                        let totalThreads = 500
                        let counter = Counter()
                        let doneIfCompleted = {
                            if counter.count >= 2 * totalThreads {
                                done()
                            }
                        }
                        
                        for _ in 0..<totalThreads {
                            dispatch_async(queue) {
                                _ = parentResolver.resolve(AnimalType.self) as! Cat
                                counter.increment()
                                doneIfCompleted()
                            }
                            dispatch_async(queue) {
                                _ = childResolver.resolve(AnimalType.self) as! Cat
                                counter.increment()
                                doneIfCompleted()
                            }
                        }
                    }
                }
                
                runInObjectScope(.None)
                runInObjectScope(.Graph)
                runInObjectScope(.Container)
                runInObjectScope(.Hierarchy)
            }
        }
    }
    
    final class Counter {
        private let lock = dispatch_queue_create("SwinjectTests.SynchronizedContainerSpec.Counter.Lock", nil)
        private var _count = 0
        
        var count: Int {
            var ret = 0
            dispatch_sync(lock) {
                ret = self._count
            }
            return ret
        }
        
        func increment() {
            dispatch_sync(lock) {
                self._count++
            }
        }
    }
}
