//
//  APIError.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public struct APIError: Codable {
    
    public let message: String
    public var formErrors: [String: String]?
    
    public func createSimpleError() -> SimpleError {
        return SimpleError(message: self.message)
    }
    
    public func createFormError() -> FormError {
        return FormError(formErrors: self.formErrors!)
    }
}
