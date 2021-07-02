//
//  UnitTestingAppDelegate.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import UIKit

@objc(UnitTestingAppDelegate)
class UnitTestingAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        return true
    }
}
