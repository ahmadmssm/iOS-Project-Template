//
//  EmailValidator.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class EmailValidator: Validatable {
    
    private let mailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    public init() {}
    
    public func validate(_ input: String?) throws {
        if(!self.isValid(input: input, with: self.mailRegex)) {
            throw ValidationError(type: .email)
        }
    }
}
