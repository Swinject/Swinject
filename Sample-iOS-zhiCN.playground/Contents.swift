/*:
# Swinject Sample for iOS
*/

import Swinject

// register 相当于添加
// resolve 相当于查找

/*:
## 基本用法
*/


protocol Animal {
    var name: String? { get set }
    func sound() -> String
}
protocol Person {
    func play() -> String
}


class Cat: Animal {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func sound() -> String {
        return "Meow!"
    }
}

class PetOwner: Person {
    let pet: Animal
    
    init(pet: Animal) {
        self.pet = pet
    }
    
    func play() -> String {
        let name = pet.name ?? "someone"
        return "I'm playing with \(name). \(pet.sound())"
    }
}

// Create a container and register service and component pairs.
// 创建 container 并 注册服务和组件对
// 创建 container
let container = Container()
// 注册服务, Animal.self 表示服务类型
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(Person.self) { r in PetOwner(pet: r.resolve(Animal.self)!) }

// The person is resolved to a PetOwner with a Cat.
// 通过 container 查找服务 Person.self，返回上面的 PetOwner(pet: r.resolve(Animal.self)!)初始化结果
let person = container.resolve(Person.self)!
print(person.play())


/////////////////////////////////////////////////////////////////////
/*:
## Named Registration 命名注册
*/

class Dog: Animal {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func sound() -> String {
        return "Bow wow!"
    }
}

// Add more registrations to the container already containing the PetOwner with the Cat.
// 添加更多记录到 container 中
// Animal.self 表示服务类型， "dog" 表示注册名称
container.register(Animal.self, name: "dog") { _ in Dog(name: "Hachi") }
container.register(Person.self, name: "doggy") { r in PetOwner(pet: r.resolve(Animal.self, name: "dog")!) }

// Resolve the service with the registration name to differentiate from the cat owner.
// 根据注册名称在 container 中查找 对应的服务，从而区分 猫的主人
let doggyPerson = container.resolve(Person.self, name:"doggy")!
print(doggyPerson.play())



/////////////////////////////////////////////////////////////////////
/*:
## Initialization Callback 初始化回调
*/

// A closure can be registered as an initCompleted callback.
// 闭包可以被注册为 initCompleted 回调
var called = false
container.register(Animal.self, name: "cb") { _ in Cat(name: "Mew") }
    .initCompleted { _, _ in called = true }
print(called)

// The closure is executed when the instance is created.
// 当实例被初始化后（ Cat(name: "Mew")初始化 ），闭包会立马执行
let catWithCallback = container.resolve(Animal.self, name: "cb")
print(called)



/////////////////////////////////////////////////////////////////////
/*:
## Injection Patterns  注入模式
*/

class InjectablePerson: Person {
    var pet: Animal? {
        didSet {
            log = "Injected by property."
        }
    }
    var log = ""
    
    init() { }
    
    init(pet: Animal) {
        self.pet = pet
        log = "Injected by initializer."
    }
    
    func setPet(_ pet: Animal) {
        self.pet = pet
        log = "Injected by method."
    }
    
    func play() -> String {
        return log
    }
}

// Initializer injection    // 初始化方法
container.register(Person.self, name: "initializer") { r in
    InjectablePerson(pet: r.resolve(Animal.self)!)
}

let initializerInjection = container.resolve(Person.self, name:"initializer")!
print(initializerInjection.play())  // Injected by initializer.

// Property injection 1 (in the component factory 属性注入)
container.register(Person.self, name: "property1") { r in
    let person = InjectablePerson()
    person.pet = r.resolve(Animal.self)
    return person
}

let propertyInjection1 = container.resolve(Person.self, name:"property1")!
print(propertyInjection1.play())    // Injected by property.

// Property injection 2 (in the initCompleted callback 初始化回调)
container.register(Person.self, name: "property2") { _ in InjectablePerson() }
    .initCompleted { r, p in
        let injectablePerson = p as! InjectablePerson
        injectablePerson.pet = r.resolve(Animal.self)
    }

let propertyInjection2 = container.resolve(Person.self, name:"property2")!
print(propertyInjection2.play())    // Injected by property.

// Method injection 1 (in the component factory)
container.register(Person.self, name: "method1") { r in
    let person = InjectablePerson()
    person.setPet(r.resolve(Animal.self)!)
    return person
}

let methodInjection1 = container.resolve(Person.self, name:"method1")!
print(methodInjection1.play())      // Injected by method.

// Method injection 2 (in the initCompleted callback)
container.register(Person.self, name: "method2") { _ in InjectablePerson() }
    .initCompleted { r, p in
        let injectablePerson = p as! InjectablePerson
        injectablePerson.setPet(r.resolve(Animal.self)!)
    }

let methodInjection2 = container.resolve(Person.self, name:"method2")!
print(methodInjection2.play())      // Injected by method.




/////////////////////////////////////////////////////////////////////
/*:
## Circular Dependency  循环依赖
*/

internal protocol ParentProtocol: AnyObject { }
internal protocol ChildProtocol: AnyObject { }

internal class Parent: ParentProtocol {
    let child: ChildProtocol?
    
    init(child: ChildProtocol?) {
        self.child = child
    }
}

internal class Child: ChildProtocol {
    weak var parent: ParentProtocol?
}

// Use initCompleted callback to set the circular dependency to avoid infinite recursion.
// 通过 initCompleted 回调来设置循环依赖，从而避免无限递归
container.register(ParentProtocol.self) { r in Parent(child: r.resolve(ChildProtocol.self)!) }
container.register(ChildProtocol.self) { _ in Child() }
    .initCompleted { r, c in
        let child = c as! Child
        child.parent = r.resolve(ParentProtocol.self)
    }

let parent = container.resolve(ParentProtocol.self) as! Parent
let child = parent.child as! Child

// The parent and child are referencing each other.
print(parent === child.parent)



/////////////////////////////////////////////////////////////////////
/*:
## Injection with Arguments  注入参数
*/

class Horse: Animal {
    var name: String?
    var running: Bool
    
    convenience init(name: String) {
        self.init(name: name, running: false)
    }

    init(name: String, running: Bool) {
        self.name = name
        self.running = running
    }
    
    func sound() -> String {
        return "Whinny!"
    }
}

// The factory closure can take arguments after the `Resolvable` parameter (in this example, unused as `_`).
// Note that the container already has an Animal without a registration name,
// but the factory with the arguments is recognized as a different registration to resolve.
// 注意：container 中已经有一个没有记录名称的 Animal类型服务了，但是可通过带有参数的工厂方法注册为一个不同的记录，从而被找到
// _（注册服务类型）, name（参数一）, running（参数二）
container.register(Animal.self) { _, name in Horse(name: name) }
container.register(Animal.self) { _, name, running in Horse(name: name, running: running) }

// The arguments to the factory are specified on the resolution.
// If you pass an argument, pass it to `argument` parameter.
// If you pass more arguments, pass them as a tuple to `arguments` parameter.
let horse1 = container.resolve(Animal.self, argument: "Spirit") as! Horse
print(horse1.name)
print(horse1.running)

let horse2 = container.resolve(Animal.self, arguments: "Lucky", true) as! Horse
print(horse2.name)
print(horse2.running)



/////////////////////////////////////////////////////////////////////
/*:
## Self-binding  自我绑定
*/

protocol MyData {
    var data: String { get }
}

class MyImportantData: MyData {
    let data = "Important data"
}

class MyController {
    var myData: MyData?
    
    func showData() -> String {
        return myData.map { $0.data } ?? ""
    }
}

// Register MyController as both service and component s to inject dependency to its property.
container.register(MyController.self) { r in MyController() }
    .initCompleted { r, c in c.myData = r.resolve(MyData.self)! }
container.register(MyData.self) { _ in MyImportantData() }

let myController = container.resolve(MyController.self)!
print(myController.showData())



/////////////////////////////////////////////////////////////////////
/*:
## Container Hierarchy 容器的层次结构
*/

let parentContainer = Container()
parentContainer.register(Animal.self, name: "cat") { _ in Cat(name: "Mimi") }

let childContainer = Container(parent: parentContainer)
childContainer.register(Animal.self, name: "dog") { _ in Dog(name: "Hachi") }

// The registration on the parent container is resolved on the child container.
let cat = childContainer.resolve(Animal.self, name: "cat")
print(cat != nil)

// The registration on the child container is not resolved on the parent container.
let dog = parentContainer.resolve(Animal.self, name: "dog")
print(dog == nil)



/////////////////////////////////////////////////////////////////////
/*:
## Object Scopes 对象范围
*/

class A {
    let b: B
    let c: C
    
    init(b: B, c: C) {
        self.b = b
        self.c = c
    }
}

class B {
    let c: C
    
    init(c: C) {
        self.c = c
    }
}

class C { }

//: ### ObjectScope.transient   transient用法

// New instatnces are created every time.
// 实例每次都被创建
let container1 = Container()
container1.register(C.self) { _ in C() }
    .inObjectScope(.transient)

let c1 = container1.resolve(C.self)
let c2 = container1.resolve(C.self)
print(c1 !== c2)    // true     实例每次都被创建，所以 c1 !== c2

// New instances are created in a object graph.
// 是在一个对象图中创建出不同的实例
container1.register(A.self) { r in A(b: r.resolve(B.self)!, c: r.resolve(C.self)!) }
container1.register(B.self) { r in B(c: r.resolve(C.self)!) }

let a1 = container1.resolve(A.self)!
print(a1.b.c !== a1.c)  // true

//: ### ObjectScope.graph   graph用法

// New instances are created like ObjectScope.transient.
// 和 .transient一样，.graph 实例每次都被创建
let container2 = Container()
container2.register(C.self) { _ in C() }
    .inObjectScope(.graph) // This is the default scope.

let c3 = container2.resolve(C.self)
let c4 = container2.resolve(C.self)
print(c3 !== c4)    // true

// But unlike ObjectScope.transient, the same instance is resolved in the object graph.
// 和 .transient 不一样，.graph 在一个对象图中创建出相同的实例
container2.register(A.self) { r in A(b: r.resolve(B.self)!, c: r.resolve(C.self)!) }
container2.register(B.self) { r in B(c: r.resolve(C.self)!) }

let a2 = container2.resolve(A.self)!
print(a2.b.c === a2.c)  // true

//: ### ObjectScope.container   container用法

// The same instance is shared in the container
// 使用 .container 可创建相同实例
let container4 = Container()
container4.register(C.self) { _ in C() }
    .inObjectScope(.container)

let c8 = container4.resolve(C.self)
let c9 = container4.resolve(C.self)
print(c8 === c9)    // true

// The instance in the parent container is shared to its child container.
// 父容器中的实例被共享到它的子容器中
let childOfContainer4 = Container(parent: container4)
let c10 = childOfContainer4.resolve(C.self)
print(c8 === c10)   // true



/////////////////////////////////////////////////////////////////////
/*:
## Injection of Value s     通过 值 注入
*/

struct Turtle: Animal {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func sound() -> String {
        return "Ninja!"
    }
}

// A value  can be registered as a component.
// The object scope is ignored because a value  always creates a new instance.
// value 作为一个组件 来注入
let container5 = Container()
container5.register(Animal.self) { _ in Turtle(name: "Reo") }
    .inObjectScope(.container)

var turtle1 = container5.resolve(Animal.self)!
var turtle2 = container5.resolve(Animal.self)!

// Still the  of turtle1 and turtle2 is Animal protocol, they work as value s.
// (Try editing 'var turtle1' to 'let turtle1', then you see a compilation error!)
turtle1.name = "Laph"   // 相当于注册了另一个，所以 这里 turtle1 不能用 let，只能用 var
print(turtle1.name!)
print(turtle2.name!)
