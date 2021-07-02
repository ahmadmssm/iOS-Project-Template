//
//  UIFont+AppFont.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 25/06/2021.
//
//  Ref: https://stackoverflow.com/questions/8707082/set-a-default-font-for-whole-ios-app
//  Ref: https://fabcoding.com/2019/11/30/set-default-custom-font-for-entire-app-swift-5/

import UIKit.UIFont

extension UIFont {
    
    private static var isOverridden: Bool = false
    
    @objc convenience init?(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(myCoder: aDecoder)
            return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage", "CTFontMediumUsage":
            fontName = AppFont.lightFont.name
        case "CTFontEmphasizedUsage",
             "CTFontBoldUsage",
             "CTFontSemiboldUsage",
             "CTFontHeavyUsage",
             "CTFontBlackUsage":
            fontName = AppFont.boldFont.name
        case "CTFontObliqueUsage":
            fontName = AppFont.italicFont.name
        default:
            fontName = AppFont.lightFont.name
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)
    }
    
    static func initCustomFonts() {
        AppFont.registerCustomFonts()
        self.overrideDefaultFonts()
    }
    
    static func overrideDefaultFonts() {
        guard self == UIFont.self, !self.isOverridden else { return }
        // Avoid method swizzling run twice and revert to original initialize function
        self.isOverridden = true
        //
        self.swizzleClassMethod(originalSelector: #selector(systemFont(ofSize: weight:)),
                                newSelector: #selector(appFont(ofSize: weight:)))
        self.swizzleClassMethod(originalSelector: #selector(systemFont(ofSize:)),
                                newSelector: #selector(self.lightFont(ofSize:)))
        self.swizzleClassMethod(originalSelector: #selector(boldSystemFont(ofSize:)),
                                newSelector: #selector(boldFont(ofSize:)))
        self.swizzleClassMethod(originalSelector: #selector(italicSystemFont(ofSize:)),
                                newSelector: #selector(italicFont(ofSize:)))
        // Trick to get over the lack of UIFont.init(coder:))
        if let initCoderMethod = self.getInstanceMethod(for: #selector(UIFontDescriptor.init(coder:))),
           let myInitCoderMethod = self.getInstanceMethod(for: #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
    
    @objc public static func appFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        return AppFont.font(ofSize: size, weight: weight)
    }
    
    @objc private static func lightFont(ofSize size: CGFloat) -> UIFont {
        return AppFont.lightFont(ofSize: size)
    }
    
    @objc private static func mediumFont(ofSize size: CGFloat) -> UIFont {
        return AppFont.mediumFont(ofSize: size)
    }
    
    @objc private static func boldFont(ofSize size: CGFloat) -> UIFont {
        return AppFont.boldFont(ofSize: size)
    }
    
    @objc private static func italicFont(ofSize size: CGFloat) -> UIFont {
        return AppFont.italicFont(ofSize: size)
    }
    
    private static func swizzleClassMethod(originalSelector: Selector, newSelector: Selector) {
        if let systemFontMethod = self.getClassMethod(for: originalSelector),
           let appFontMethod = self.getClassMethod(for: newSelector) {
            method_exchangeImplementations(systemFontMethod, appFontMethod)
        }
    }
    
    private static func getClassMethod(for selector: Selector) -> Method? {
        return class_getClassMethod(self, selector)
    }
    
    private static func getInstanceMethod(for selector: Selector) -> Method? {
        return class_getInstanceMethod(self, selector)
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}
