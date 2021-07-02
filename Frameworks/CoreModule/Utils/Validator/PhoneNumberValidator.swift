//
//  PhoneNumberValidator.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class PhoneNumberValidator: Validatable {
    
    private let mobileRegex = "^01[0-2]{1}[0-9]{8}"
    
    public init() {}
    
    public func validate(_ input: String?) throws {
        if(!self.isValid(input: input, with: self.mobileRegex)) {
            throw ValidationError(type: .mobileNumber)
        }
    }
}
