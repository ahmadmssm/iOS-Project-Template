//
//  MainNavigatorProtocol.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import UIKit

public protocol MainNavigatorProtocol: NavigationServiceProtocol {
    var window: UIWindow! { get }
    func startInitialViewController()
    func openCoreDataExample(from viewController: UIViewController)
}
