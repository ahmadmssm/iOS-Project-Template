//
//  AppNavigationController.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 27/02/2021.
//

import UIKit

public class AppNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient
    }()
    private lazy var customBackBarButtonItem = {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.configureNavigationBarAppearance()
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        if let image = UIImage.createFrom(gradientLayer: self.gradientLayer) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController, animated: Bool) {
        // Remove back button text from all view controllers
        viewController.navigationItem.backBarButtonItem = customBackBarButtonItem
    }
    
    private func configureNavigationBarAppearance() {
        let tabBarFont = UIFont.appFont(ofSize: 34, weight: .medium)
        let titleStyle = [NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: tabBarFont]
        let navBarBackButtonIcon = self.backButtonIcon(isRTL: UIApplication.isRTL)
        self.navigationBar.apply {
            $0.titleTextAttributes = titleStyle
            // BackButtonColor
            $0.tintColor = UIColor.darkOrange
            //
            $0.barTintColor = .white
            $0.backIndicatorImage = navBarBackButtonIcon
            $0.backIndicatorTransitionMaskImage = navBarBackButtonIcon
        }
    }
}
