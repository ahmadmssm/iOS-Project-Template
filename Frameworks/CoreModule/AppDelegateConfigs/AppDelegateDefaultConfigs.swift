//
//  AppDelegateDefaultConfigs.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import UIKit
import IQKeyboardManagerSwift

public class AppDelegateDefaultConfigs: BaseAppDelegateConfig {
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        EnvironmentUtils.doIfDebug {
            NFX.sharedInstance().start()
        }
        /*
         Uncomment and add/update the names of the fonts and add/update the .ttf files
         in the resources module in case custom fonts are needed in the future.
         */
        // UIFont.initCustomFonts()
        self.initIQKeyboardManager()
        return true
    }
    
    private func initIQKeyboardManager() {
        IQKeyboardManager.shared.apply {
            $0.enable = true
            $0.shouldResignOnTouchOutside = true
            $0.shouldShowToolbarPlaceholder = false
            $0.enableAutoToolbar = false
        }
        // To uncomment later
        // IQKeyboardManager.shared.disabledToolbarClasses = [SplashScreenVC.self]
        // iqKeyboardManager.disabledDistanceHandlingClasses.append(ViewController.self)
    }
}
