//
//  CompositeError.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class CompositeError: AppError {
    
    private(set) var errors: [AppError]?
    
    public init(errors: [AppError]) {
        self.errors = errors
    }
}
