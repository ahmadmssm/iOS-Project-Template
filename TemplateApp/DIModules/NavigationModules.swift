//
//  NavigationModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 16/06/2021.
//

import CoreModule
import ServicesModule

extension Resolver {
    static func registerNavigationModules() {
        register { MainNavigator() }.implements(MainNavigatorProtocol.self).scope(.application)
    }
}
