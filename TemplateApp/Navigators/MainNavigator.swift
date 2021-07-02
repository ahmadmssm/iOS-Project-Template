//
//  MainNavigator.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 16/06/2021.
//

import UIKit
import CoreModule
import ServicesModule
import CustomComponentsModule
import AppCoreFeatures

public class MainNavigator: BaseAppDelegateConfig, MainNavigatorProtocol {
    
    private(set) public var window: UIWindow!
    
    override init() {
        super.init()
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        self.startInitialViewController()
        return true
    }
    
    public func startInitialViewController() {
        let tabs = [TestViewController.create(navigator: self),
                    TestViewController.create(navigator: self),
                    TestViewController.create(navigator: self),
                    TestViewController.create(navigator: self)]
        let rootViewController = AppTabBarController(tabs: tabs)
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionFlipFromLeft,
            animations: {
                self.window.rootViewController = rootViewController
                self.window.makeKeyAndVisible()
            }, completion: nil)
    }
}
