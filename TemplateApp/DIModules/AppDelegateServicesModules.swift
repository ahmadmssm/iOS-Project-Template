//
//  AppDelegateServicesModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import DataModule
import CoreModule
import CustomComponentsModule

extension Resolver {
    static func registerAppDelegateServicesModules() {
        register { AppDelegateDefaultConfigs() }
        register { AppDelegateFirebaseConfigs() }
    }
}
