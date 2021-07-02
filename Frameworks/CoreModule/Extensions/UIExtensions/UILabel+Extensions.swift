//
//  UILabel+Localization.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 5/18/21.
//

import UIKit

public extension UILabel {
    @IBInspectable var localizedLabel: String {
        get {
            return self.localizedLabel
        } set {
            let newValue = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            self.text = newValue.localized
        }
    }
}
