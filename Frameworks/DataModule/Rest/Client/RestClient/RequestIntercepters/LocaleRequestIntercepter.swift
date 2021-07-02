//
//  LocaleRequestIntercepter.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 08/06/2021.
//

import Alamofire
import CoreModule
import Foundation

public class LocaleRequestIntercepter: RequestIntercepterProtocol {
    
    private let languageManagerProtocol: LanguageManagerProtocol

    public init(languageManagerProtocol: LanguageManagerProtocol) {
        self.languageManagerProtocol = languageManagerProtocol
    }
    
    public func modifyURLRequest(_ urlRequest: inout URLRequest) {
        urlRequest.setValue(self.getCurrentLanguageKey(), forHTTPHeaderField: "Accept-Language")
    }
    
    private func getCurrentLanguageKey() -> String {
        self.languageManagerProtocol.getCurrentLanguageKey()
    }
}
