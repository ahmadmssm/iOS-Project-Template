//
//  UIButton+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 06/04/2021.
//

import UIKit.UIButton

public extension UIButton {
    
    func setUnderlined() {
        guard let text = self.currentTitle else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func enable() {
        self.alpha = 1.0
        self.isEnabled = true
    }
    
    func disable() {
        self.alpha = 0.5
        self.isEnabled = false
    }
    
    @IBInspectable var localizedLabel: String {
        get {
            return self.localizedLabel
        } set {
            self.setTitle(newValue.localized, for: .normal)
        }
    }
}
