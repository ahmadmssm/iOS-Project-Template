//
//  BaseLanguageManager.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/06/2021.
//

import UIKit

/// L102Language
public class BaseLanguageManager<T: LocaleProtocol> {
    
    private let userDefaults = UserDefaults.standard
    // Note : This key is Apple specific key and not any key can be used
    private final var appleLanguagesKey = "AppleLanguages"
    
    public init() {}
    
    func getDefaultDeviceLanguage() -> String {
        return NSLocale.preferredLanguages[0]
    }
    
    public func getCurrentLocale() -> T {
        let languages = userDefaults.stringArray(forKey: appleLanguagesKey)
        if let defaultLocaleKey = languages?.first,
           let appLocale = T.init(localeKey: defaultLocaleKey) {
            return appLocale
        }
        fatalError("Locale not defined!")
    }
    
    // This function uses Swizzling to update the App language without restarting the App manually.
    public func setAndSwitch(to locale: T) {
        //
        // - To do : Auto refresh current view controller -
        //
        self.swizzleUIComponents()
        self.setAppLocale(locale: locale)
    }
    
    private func setAppLocale(locale: T) {
        let appleLanguage = self.getCurrentLocale()
        if (!locale.key.isEqual(appleLanguage)) {
            let appLanguages = [locale.key, self.getCurrentLocale().key]
            self.userDefaults.set(appLanguages, forKey: appleLanguagesKey)
            //
            let isRTL = locale.isRTL
            UIView.appearance().semanticContentAttribute =  isRTL ? .forceRightToLeft : .forceLeftToRight
        }
    }
    
    private func swizzleUIComponents() {
        self.swizzleBundle()
        self.swizzleUIApplication()
    }
    
    private func swizzleBundle() {
        let clazz = Bundle.self
        let oldSelector = #selector(Bundle.localizedString(forKey:value:table:))
        let newSelector = #selector(Bundle.customLocalizedString(for:value:table:))
        SwizzlingUtils.swizzle(clazz: clazz,
                               originalSelector: oldSelector,
                               newSelector: newSelector)
    }
    
    private func swizzleUIApplication() {
        let clazz = UIApplication.self
        let originalSelector = #selector(getter: UIApplication.userInterfaceLayoutDirection)
        let newSelector = #selector(getter: UIApplication.customizedUserInterfaceDirection)
        SwizzlingUtils.swizzle(clazz: clazz,
                               originalSelector: originalSelector,
                               newSelector: newSelector)
    }
}
