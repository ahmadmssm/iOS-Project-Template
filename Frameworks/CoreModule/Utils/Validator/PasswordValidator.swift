//
//  PasswordValidator.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class PasswordValidator: Validatable {
    
    // https://stackoverflow.com/a/39285576/6927433
    // Minimum 8 characters and at least 1 Alphabet and 1 Number.
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    
    public init() {}
    
    public func validate(_ input: String?) throws {
        if(!self.isValid(input: input, with: self.passwordRegex)) {
            throw ValidationError(type: .password)
        }
    }
}
