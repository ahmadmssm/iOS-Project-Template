//
//  NavigationServiceProtocol.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 02/07/2021.
//

import UIKit
import CoreModule

public protocol NavigationServiceProtocol {
    func openPhoneDialer(number: Int)
    func openInSafari(with url: String)
    func push(from viewController: UIViewController, destinationViewController: UIViewController)
    func present(from viewController: UIViewController, destinationViewController: UIViewController)
}

public extension NavigationServiceProtocol {
    
    func openPhoneDialer(number: Int) {
        let number = Constants.contactUsNumber
        if  let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openInSafari(with url: String) {
        if let webViewURL = URL(string: url) {
            UIApplication.shared.open(webViewURL)
        }
    }
    
    func push(from viewController: UIViewController, destinationViewController: UIViewController) {
        viewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func present(from viewController: UIViewController, destinationViewController: UIViewController) {
        destinationViewController.modalPresentationStyle = .fullScreen
        viewController.present(destinationViewController, animated: true, completion: nil)
    }
}
