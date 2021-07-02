//
//  AppFont.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 25/06/2021.
//

import UIKit.UIFont

public enum AppFont {
    
    case lightFont
    case mediumFont
    case boldFont
    case italicFont
    
    public var name: String {
        return (UIApplication.isRTL ? self.arFontName: self.enFontName)
    }
    
    public var arFontName: String {
        switch self {
        case .lightFont:
            return "Helvetica"
        case .mediumFont:
            return "Helvetica"
        case .boldFont:
            return "Almarai-Bold"
        case .italicFont:
            fatalError("No italic font!")
        }
    }
    
    public var enFontName: String {
        switch self {
        case .lightFont:
            return "Tungsten-Medium"
        case .mediumFont:
            return "CeraPRO-Bold"
        case .boldFont:
            return "CeraPRO-Regular"
        case .italicFont:
            fatalError("No italic font!")
        }
    }
    
    public static func font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .semibold, .bold, .heavy, .black:
            return self.boldFont(ofSize: size)
        case .medium, .regular:
            return self.mediumFont(ofSize: size)
        default:
            return self.lightFont(ofSize: size)
        }
    }
    
    public static func lightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: self.lightFont.name, size: size) ?? self.getFallbackFont(size: size)
    }
    
    public static func mediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: self.mediumFont.name, size: size) ?? self.getFallbackFont(size: size)
    }
    
    public static func boldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: self.boldFont.name, size: size) ?? self.getFallbackFont(size: size)
    }
    
    public static func italicFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: self.italicFont.name, size: size) ?? self.getFallbackFont(size: size)
    }
    
    private static func getFallbackFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func registerCustomFonts() {
        let fontURLs = Bundle.resources.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fontURLs?.forEach {
            CTFontManagerRegisterFontsForURL($0 as CFURL, .process, nil)
        }
    }
}
