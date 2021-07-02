//
//  AppLanguageManager.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/06/2021.
//

public class AppLanguageManager: BaseLanguageManager<AppLocales>, LanguageManagerProtocol {
    
    public func switchAppLanguage() {
        if(self.getCurrentLocale() == .english) {
            self.setAndSwitch(to: .arabic)
        }
        else {
            self.setAndSwitch(to: .english)
        }
    }
    
    public func getCurrentLanguageKey() -> String {
        return self.getCurrentLocale().key
    }
    
    public func getCurrentLanguageTag() -> String {
        return self.getCurrentLocale().tag
    }
    
    public func secondaryLanguage() -> String {
        return AppLocales.allCases.first { $0 != self.getCurrentLocale() }!.localizedName
    }
    
    public func secondaryLanguageKey() -> String {
        return AppLocales.allCases.first { $0 != self.getCurrentLocale() }!.key
    }
    
    public func getCurrentLanguageId() -> Int {
        return AppLocales.allCases.firstIndex { $0 == self.getCurrentLocale() } ?? 0
    }
    
    public func getLanguageKey(at index: Int) -> String {
        return AppLocales.allCases[index].key
    }
}
