//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable identifier_name
// sourcery:inline:BindingFactoryApi
public extension Binding {
    func factory<NewInstance>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping () throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { _, _ in try factory() }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = []
        }
    }

    func factory<NewInstance>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>) throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { r, _ in try factory(r) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = []
        }
    }

    func factory<NewInstance, Arg1>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1) throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { r, a in try factory(r, a.arg(0)) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = [Arg1.self]
        }
    }

    func factory<NewInstance, Arg1, Arg2>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2) throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { r, a in try factory(r, a.arg(0), a.arg(1)) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = [Arg1.self, Arg2.self]
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3) throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { r, a in try factory(r, a.arg(0), a.arg(1), a.arg(2)) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = [Arg1.self, Arg2.self, Arg3.self]
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3, Arg4>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3, Arg4) throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { r, a in try factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3)) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = [Arg1.self, Arg2.self, Arg3.self, Arg4.self]
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3, Arg4, Arg5>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> NewInstance) -> Binding<NewInstance, Context> {
        return updatedFactory { r, a in try factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3), a.arg(4)) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = []
            $0.arguments = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self]
        }
    }
}

// sourcery:end
