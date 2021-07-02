//
//  AppDelegate+Injection..swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//
//  Ref: https://github.com/hmlongco/Resolver/blob/master/Documentation/Registration.md

import CoreModule
import DataModule

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        setResolverDefaultScope()
        registerViewModelModules()
        registerServicesModules()
        registerRestModules()
        registerRepositoriesModules()
        registerDataSourcesModules()
        registerAppDelegateServicesModules()
        registerNavigationModules()
        registerOtherModules()
    }
    
    static func setResolverDefaultScope() {
        Resolver.defaultScope = .unique
    }
}
