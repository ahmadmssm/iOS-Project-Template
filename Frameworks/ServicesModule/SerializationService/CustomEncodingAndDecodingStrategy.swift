//
//  CustomEncodingAndDecodingStrategy.swift
//  ServicesModule
//
//  Created by Ahmad Mahmoud on 04/07/2021.
//

import Foundation

struct AnyKey: CodingKey {
    
    var intValue: Int?
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}

extension JSONEncoder.KeyEncodingStrategy {
    
    static var convertToPascalCase: JSONEncoder.KeyEncodingStrategy {
        return .custom { keys in
            let lastKey = keys.last!
            guard lastKey.intValue == nil else { return lastKey }
            let stringValue = lastKey.stringValue.prefix(1).uppercased() + lastKey.stringValue.dropFirst()
            return AnyKey(stringValue: stringValue)!
        }
    }
}

extension JSONDecoder.KeyDecodingStrategy {
    
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys in
            let lastKey = keys.last!
            guard lastKey.intValue == nil else { return lastKey }
            let stringValue = lastKey.stringValue.prefix(1).lowercased() + lastKey.stringValue.dropFirst()
            return AnyKey(stringValue: stringValue)!
        }
    }
}
