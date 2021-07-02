//
//  OtherModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import UIKit
import DataModule
import CoreData
import CoreModule
import CustomComponentsModule

extension Resolver {
    static func registerOtherModules() {
        register { _ -> UIWindow in
            let navigator: MainNavigator = resolve()
            return navigator.window
        }
        register { _ -> NSManagedObjectContext in
            let name = EnvironmentVariables.getCoreDataContainerName()
            return CoreDataContextProvider.createNSManagedObjectContext(containerName: name)
        }.scope(.application)
        register {
            NetworkLoaderOverlay(backgroundColor: .transparentBlack)
        }.scope(.application)
        register { EmailValidator() }
        register { PasswordValidator() }
        register { PhoneNumberValidator() }
        register { AppLanguageManager() as LanguageManagerProtocol }.scope(.application)
    }
}
