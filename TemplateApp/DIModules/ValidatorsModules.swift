//
//  ValidatorsModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 19/07/2021.
//

import CoreModule

extension Resolver {
    static func registerValidatorsModules() {
        register { EmailValidator() }
        register { PasswordValidator() }
        register { PhoneNumberValidator() }
    }
}
