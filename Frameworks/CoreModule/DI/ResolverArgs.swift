//
//  ResolverArgs.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/03/2021.
//

public class ResolverArgs {
    
    private var arguments: [Any?] = []
    
    init<T0, T1, T2, T3, T4, T5>(arg0: T0? = nil,
                                 arg1: T1? = nil,
                                 arg2: T2? = nil,
                                 arg3: T3? = nil,
                                 arg4: T4? = nil,
                                 arg5: T5? = nil) {
        arguments.append(arg0)
        arguments.append(arg1)
        arguments.append(arg2)
        arguments.append(arg3)
        arguments.append(arg4)
    }
    
    public func arg0<T>() -> T? {
        return self.getArgumentAt(index: 0)
    }
    
    public func arg1<T>() -> T? {
        return self.getArgumentAt(index: 1)
    }
    
    public func arg2<T>() -> T? {
        return self.getArgumentAt(index: 2)
    }
    
    public func arg3<T>() -> T? {
        return self.getArgumentAt(index: 3)
    }
    
    public func arg4<T>() -> T? {
        return self.getArgumentAt(index: 4)
    }
    
    public func arg5<T>() -> T? {
        return self.getArgumentAt(index: 5)
    }
    
    private func getArgumentAt<T>(index: Int) -> T? {
        if let argument = self.arguments[exist: index] as? T {
            return argument
        }
        // Wrong Argument index
        // fatalError("Wrong Argument index")
        return nil
    }
}
