//
//  SynchronizedResolverSpec.swift
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
                            child.parent = r.resolve(ParentType.self)
                        }
                        .inObjectScope(.Graph)
                }.synchronize()
                
                waitUntil(timeout: 2.0) { done in
                    let queue = dispatch_queue_create("SwinjectTests.SynchronizedContainerSpec.Queue", DISPATCH_QUEUE_CONCURRENT)
                    let totalThreads = 500 // 500 threads are enough to get fail unless the container is thread safe.
                    let counter = Counter(max: 2 * totalThreads)
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
                        let counter = Counter(max: 2 * totalThreads)
                        
                        for _ in 0..<totalThreads {
                            dispatch_async(queue) {
                                _ = parentResolver.resolve(AnimalType.self) as! Cat
                                if counter.increment() == .ReachedMax {
                                    done()
                                }
                            }
                            dispatch_async(queue) {
                                _ = childResolver.resolve(AnimalType.self) as! Cat
                                if counter.increment() == .ReachedMax {
                                    done()
                                }
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
        enum Status {
            case UnderMax, ReachedMax
        }
        
        private var max: Int
        private let lock = dispatch_queue_create("SwinjectTests.SynchronizedContainerSpec.Counter.Lock", nil)
        private var count = 0

        init(max: Int) {
            self.max = max
        }
        
        func increment() -> Status {
            var status = Status.UnderMax
            dispatch_sync(lock) {
                self.count += 1
                if self.count >= self.max {
                    status = .ReachedMax
                }
            }
            return status
        }
    }
}
