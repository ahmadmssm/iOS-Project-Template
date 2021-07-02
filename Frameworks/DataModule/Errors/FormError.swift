//
//  FormError.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class FormError: AppError {
    
    public private(set) var errors: [String: String]
    
    init(formErrors: [String: String]) {
        self.errors = formErrors
        super.init()
    }
}
