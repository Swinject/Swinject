//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable identifier_name
// swiftlint:disable large_tuple
// sourcery:inline:BindingFactoryApi
public extension Binding {
    func factory<NewInstance>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping () throws -> NewInstance) -> Binding<NewInstance, AScope, Context, NoArgument> {
        return updatedFactory { _, _ in try factory() }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, NoArgument> {
        return updatedFactory { r, _ in try factory(r) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, Arg1> {
        return updatedFactory { r, a in try factory(r, a) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, MatchableBox1<Arg1>> where Arg1: Hashable {
        return updatedFactory { r, a in try factory(r, a.arg1) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, (Arg1, Arg2)> {
        return updatedFactory { r, a in try factory(r, a.0, a.1) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, MatchableBox2<Arg1, Arg2>> where Arg1: Hashable, Arg2: Hashable {
        return updatedFactory { r, a in try factory(r, a.arg1, a.arg2) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, (Arg1, Arg2, Arg3)> {
        return updatedFactory { r, a in try factory(r, a.0, a.1, a.2) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, MatchableBox3<Arg1, Arg2, Arg3>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        return updatedFactory { r, a in try factory(r, a.arg1, a.arg2, a.arg3) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3, Arg4>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3, Arg4) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, (Arg1, Arg2, Arg3, Arg4)> {
        return updatedFactory { r, a in try factory(r, a.0, a.1, a.2, a.3) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3, Arg4>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3, Arg4) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        return updatedFactory { r, a in try factory(r, a.arg1, a.arg2, a.arg3, a.arg4) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3, Arg4, Arg5>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        return updatedFactory { r, a in try factory(r, a.0, a.1, a.2, a.3, a.4) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }

    func factory<NewInstance, Arg1, Arg2, Arg3, Arg4, Arg5>(for _: NewInstance.Type = NewInstance.self, tag: String? = nil, factory: @escaping (ContextedResolver<Context>, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> NewInstance) -> Binding<NewInstance, AScope, Context, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        return updatedFactory { r, a in try factory(r, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }.updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }
}

// sourcery:end
