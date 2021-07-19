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
import ExamplesFeature

public class MainNavigator: BaseAppDelegateConfig, MainNavigatorProtocol, ExamplesNavigatorProtocol {
    
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
    
    public func openCoreDataExample(from viewController: UIViewController) {
        let navigator: ExamplesNavigatorProtocol = Resolver.resolve()
        let destinationViewController = MyViewController.create(navigator: navigator)
        self.push(from: viewController, destinationViewController: destinationViewController)
    }
}
