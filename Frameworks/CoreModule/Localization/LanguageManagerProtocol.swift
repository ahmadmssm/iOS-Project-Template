//
//  LanguageManagerProtocol.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 08/06/2021.
//

public protocol LanguageManagerProtocol {
    func switchAppLanguage()
    func getCurrentLanguageKey() -> String
    func getCurrentLanguageTag() -> String
    func secondaryLanguage() -> String
    func secondaryLanguageKey() -> String
    func getCurrentLanguageId() -> Int
    func getLanguageKey(at index: Int) -> String
    func getCurrentLocale() -> AppLocales
}
