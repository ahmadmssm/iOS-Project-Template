//
//  LocalesProtocol.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/06/2021.
//

import UIKit

public protocol LocaleProtocol {
    var key: String { get }
    var tag: String { get }
    var name: String { get }
    var localizedName: String { get }
    var isRTL: Bool { get }
    var direction: UISemanticContentAttribute { get }
    var interfaceDirection: UIUserInterfaceLayoutDirection { get }
    var fallbackLocale: LocaleProtocol { get }
    var fallbackLocaleKey: String { get }
    init?(localeKey: String)
}
