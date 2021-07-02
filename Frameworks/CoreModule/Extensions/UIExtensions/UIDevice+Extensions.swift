//
//  UIDevice+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 10/03/2021.
//

import UIKit

public extension UIDevice {
    static var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}
