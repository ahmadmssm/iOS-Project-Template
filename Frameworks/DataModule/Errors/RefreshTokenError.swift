//
//  RefreshTokenError.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class RefreshTokenError: AppError {
    
    public let originalRequestError: Error
    
    init(originalRequestError: Error) {
        self.originalRequestError = originalRequestError
    }
}
