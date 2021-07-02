//
//  DependencyResolver.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

/*
 This class acts as a proxy between the Resolver framework and our code.
 I created it to remove the direct dependency on Resolver itself.
 */
public class DependencyResolver {
    
    public static func resolve<T>() -> T {
        Resolver.resolve()
    }
    
    public static func resolveOptional<T>() -> T? {
        Resolver.optional()
    }
    
    public static func resolveOptional<T>(arg0: Any? = nil,
                                          arg1: Any? = nil,
                                          arg2: Any? = nil,
                                          arg3: Any? = nil,
                                          arg4: Any? = nil,
                                          arg5: Any? = nil) -> T? {
        return Resolver.optional(arg0: arg0, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5)
    }
}
