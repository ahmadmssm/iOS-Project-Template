//
//  LocalizationExtensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/06/2021.
//

import UIKit

extension Bundle {
    @objc func customLocalizedString(for key: String, value: String?, table tableName: String?) -> String {
        //
        let currentLanguage = Locale.preferredLanguages[0]
        let fileExtension: String = "lproj"
        var bundle: Bundle!
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: fileExtension) {
            bundle = Bundle(path: path)
        }
        else {
            let path = Bundle.main.path(forResource: "Base", ofType: fileExtension)
            bundle = Bundle(path: path!)
        }
        //
        return bundle.customLocalizedString(for: key, value: value, table: tableName)
    }
}

extension UIApplication {
    @objc var customizedUserInterfaceDirection: UIUserInterfaceLayoutDirection {
        // Default app direction
        var direction: UIUserInterfaceLayoutDirection = .leftToRight
        //
        let appLang = Locale.preferredLanguages[0]
        if ((appLang.range(of: "ar")) != nil) {
            direction = .rightToLeft
        }
        //
        return direction
    }
}

public extension UIApplication {
    static var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}
