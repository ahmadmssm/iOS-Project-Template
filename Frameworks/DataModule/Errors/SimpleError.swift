//
//  SimpleError.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public class SimpleError: Error {
    
    public let message: String
        
    public init(message: String) {
        self.message = message
    }
}
