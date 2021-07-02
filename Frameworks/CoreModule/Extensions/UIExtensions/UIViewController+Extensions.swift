//
//  UIViewController+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 25/02/2021.
//

import UIKit
import ResourcesModule

public extension UIViewController {
    
    func backButtonIcon(isRTL: Bool) -> UIImage {
        let icon = #imageLiteral(resourceName: "Icon_back")
        return isRTL ? icon.imageFlippedForRightToLeftLayoutDirection() : icon
    }
    
    func setNavigationBarTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    func removeNavigationBarBackground() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func removeNavigationBarBottomBorder() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func restoreNavigationBarBottomBorder() {
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func showNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideNavigationController() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func addRightBarButtonItem(icon: UIImage, selector: Selector) {
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: selector)
        self.navigationItem.rightBarButtonItem = button
    }
    
    func popSelf(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    static func initFromNib<T: UIViewController>() -> T {
        let nib = UINib(nibName: className, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! T
    }
}
