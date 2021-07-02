//
//  AppDelegate.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 16/02/2021.
//

import UIKit
import DataModule
import CoreModule
import CustomComponentsModule

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var appDelegateServices: [UIApplicationDelegate] = {
        // Should be the first thing
        let defaultConfigs: AppDelegateDefaultConfigs = DependencyResolver.resolve()
        let firebaseConfigs: AppDelegateFirebaseConfigs = DependencyResolver.resolve()
        // Should be the last thing.
        let navigator: MainNavigator = DependencyResolver.resolve()
        return [defaultConfigs, firebaseConfigs, navigator]
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appDelegateServices.forEach {
            _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
}
