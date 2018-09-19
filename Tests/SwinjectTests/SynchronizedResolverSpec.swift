//
//  SynchronizedResolverSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Dispatch
import Quick
import Nimble
@testable import Swinject

class SynchronizedResolverSpec: QuickSpec {
    override func spec() {
        describe("Multiple threads") {
            it("can resolve circular dependencies.") {
                let container = Container { container in
                    container.register(ParentProtocol.self) { _ in Parent() }
                        .initCompleted { r, s in
                            let parent = s as! Parent
                            parent.child = r.resolve(ChildProtocol.self)
                        }
                        .inObjectScope(.graph)
                    container.register(ChildProtocol.self) { _ in Child() }
                        .initCompleted { r, s in
                            let child = s as! Child
                            child.parent = r.resolve(ParentProtocol.self)!
                        }
                        .inObjectScope(.graph)
                }.synchronize()

                onMultipleThreads {
                    let parent = container.resolve(ParentProtocol.self) as! Parent
                    let child = parent.child as! Child
                    expect(child.parent as? Parent === parent).to(beTrue()) // Workaround for crash in Nimble
                }
            }
            it("can access parent and child containers without dead lock.") {
                let runInObjectScope = { (scope: ObjectScope) in
                    let parentContainer = Container { container in
                        container.register(Animal.self) { _ in Cat() }
                            .inObjectScope(scope)
                    }
                    let parentResolver = parentContainer.synchronize()
                    let childResolver = Container(parent: parentContainer).synchronize()

                    onMultipleThreads(actions: [
                        { _ = parentResolver.resolve(Animal.self) as! Cat },    // swiftlint:disable:this opening_brace
                        { _ = childResolver.resolve(Animal.self) as! Cat }
                    ])
                }

                runInObjectScope(.transient)
                runInObjectScope(.graph)
                runInObjectScope(.container)
            }
            it("uses distinct graph identifier") {
                var graphs = Set<GraphIdentifier>()
                let container = Container {
                    $0.register(Dog.self) {
                        graphs.insert(($0 as! Container).currentObjectGraph!)
                        return Dog()
                    }
                }.synchronize()

                onMultipleThreads { _ = container.resolve(Dog.self) }

                expect(graphs.count) == totalThreads
            }
        }
        describe("Nested resolve") {
            it("can make it without deadlock") {
                let container = Container()
                let threadSafeResolver = container.synchronize()
                container.register(ChildProtocol.self) { _ in  Child() }
                container.register(ParentProtocol.self) { _ in
                    Parent(child: threadSafeResolver.resolve(ChildProtocol.self)!)
                }

                let queue = DispatchQueue(
                    label: "SwinjectTests.SynchronizedContainerSpec.Queue", attributes: .concurrent
                )
                waitUntil(timeout: 2.0) { done in
                    queue.async {
                        _ = threadSafeResolver.resolve(ParentProtocol.self)
                        done()
                    }
                }
            }
        }
    }
}

fileprivate final class Counter {
    enum Status {
        case underMax, reachedMax
    }

    private var max: Int
    private let lock = DispatchQueue(label: "SwinjectTests.SynchronizedContainerSpec.Counter.Lock", attributes: [])
    var count = 0

    init(max: Int) {
        self.max = max
    }

    @discardableResult
    func increment() -> Status {
        var status = Status.underMax
        lock.sync {
            self.count += 1
            if self.count >= self.max {
                status = .reachedMax
            }
        }
        return status
    }
}

private let totalThreads = 500 // 500 threads are enough to get fail unless the container is thread safe.

private func onMultipleThreads(action: @escaping () -> Void) {
    onMultipleThreads(actions: [action])
}

private func onMultipleThreads(actions: [() -> Void]) {
    waitUntil(timeout: 2.0) { done in
        let queue = DispatchQueue(
            label: "SwinjectTests.SynchronizedContainerSpec.Queue",
            attributes: .concurrent
        )
        let counter = Counter(max: actions.count * totalThreads)
        for _ in 0..<totalThreads {
            actions.forEach { action in
                queue.async {
                    action()
                    if counter.increment() == .reachedMax {
                        done()
                    }
                }
            }
        }
    }
}
