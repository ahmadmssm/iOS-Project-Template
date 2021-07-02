//
//  Validatable.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

import Foundation

public protocol Validatable {
    func validate(_ input: String?) throws
}

extension Validatable {
    
    func isValid(input: String?, with regex: String) -> Bool {
        guard
            let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        else {
            assertionFailure("Regex not valid")
            return false
        }
        if let input = input {
            let range = NSRange(location: 0, length: input.count)
            let regexFirstMatch = regex.firstMatch(in: input, options: [], range: range)
            return regexFirstMatch != nil
        }
        return false
    }
}
