//
//  AppLocales.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/06/2021.
//

import UIKit

public enum AppLocales: String, LocaleProtocol, CaseIterable {
    
    case english
    case arabic
    
    public var key: String {
        switch self {
        case .english:
            return "en_US"
        default:
            return "ar_EG"
        }
    }
    
    public var tag: String {
        switch self {
        case .english:
            return "en"
        default:
            return "ar"
        }
    }
    
    public var name: String {
        self.rawValue
    }
    
    public var localizedName: String {
        switch self {
        case .english:
            return "english".localized
        default:
            return "arabic".localized
        }
    }
    
    public var isRTL: Bool {
        return self.key.range(of: "ar", options: .caseInsensitive) != nil
    }
    
    public var direction: UISemanticContentAttribute {
        return self.isRTL ? .forceRightToLeft : .forceLeftToRight
    }
    
    public var interfaceDirection: UIUserInterfaceLayoutDirection {
        return self.isRTL ? .rightToLeft : .leftToRight
    }
    
    public var fallbackLocale: LocaleProtocol {
        return AppLocales.english
    }
    
    public var fallbackLocaleKey: String {
        return self.fallbackLocale.key
    }
    
    public init?(localeKey: String) {
        let locale = AppLocales.allCases.first(where: { $0.key == localeKey })
        self.init(rawValue: locale?.rawValue ?? "")
    }
}
