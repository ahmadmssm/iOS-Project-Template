//
//  JWTClaim.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

import Foundation

public struct JWTClaim {
    /// raw value of the claim
    let value: Any?
    /// original claim value
    public var rawValue: Any? {
        return self.value
    }
    /// value of the claim as `String`
    public var string: String? {
        return self.value as? String
    }
    /// value of the claim as `Bool`
    public var boolean: Bool? {
        return self.value as? Bool
    }
    /// value of the claim as `Double`
    public var double: Double? {
        var double: Double?
        if let string = self.string {
            double = Double(string)
        } else if self.boolean == nil {
            double = self.value as? Double
        }
        return double
    }
    /// value of the claim as `Int`
    public var integer: Int? {
        var integer: Int?
        if let string = self.string {
            integer = Int(string)
        } else if let double = self.double {
            integer = Int(double)
        } else if self.boolean == nil {
            integer = self.value as? Int
        }
        return integer
    }
    /// value of the claim as `NSDate`
    public var date: Date? {
        guard let timestamp: TimeInterval = self.double else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }
    /// value of the claim as `[String]`
    public var array: [String]? {
        if let array = self.value as? [String] {
            return array
        }
        if let value = self.string {
            return [value]
        }
        return nil
    }
}
