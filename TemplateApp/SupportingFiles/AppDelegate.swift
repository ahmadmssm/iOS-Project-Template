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
        let defaultConfigs: AppDelegateDefaultConfigs = Resolver.resolve()
        let firebaseConfigs: AppDelegateFirebaseConfigs = Resolver.resolve()
        // Should be the last thing.
        let navigator: MainNavigator = Resolver.resolve()
        return [defaultConfigs, firebaseConfigs, navigator]
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appDelegateServices.forEach {
            _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegateServices.forEach { appDelegateService in
            _ = appDelegateService.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appDelegateServices.forEach { appDelegateService in
            _ = appDelegateService.applicationWillResignActive?(application)
        }
    }
}
