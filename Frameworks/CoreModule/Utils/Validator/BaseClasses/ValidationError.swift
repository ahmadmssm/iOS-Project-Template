//
//  ValidationError.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

import Foundation

public class ValidationError: Error {
    
    public let message: String
    public let type: ValidatorType
    
    public init(type: ValidatorType) {
        self.type = type
        self.message = type.rawValue.localized
    }
}
