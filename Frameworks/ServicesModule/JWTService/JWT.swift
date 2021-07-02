//
//  JWT.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

import Foundation

public struct JWT {
    
    private let header: [String: Any]
    private let body: [String: Any]
    //
    public var expiresAt: Date? { return claim(name: "exp").date }
    public var issuer: String? { return claim(name: "iss").string }
    public var subject: String? { return claim(name: "sub").string }
    public var audience: [String]? { return claim(name: "aud").array }
    public var issuedAt: Date? { return claim(name: "iat").date }
    public var notBefore: Date? { return claim(name: "nbf").date }
    public var identifier: String? { return claim(name: "jti").string }
    public var expired: Bool {
        guard let date = self.expiresAt else {
            return false
        }
        return date.compare(Date()) != ComparisonResult.orderedDescending
    }
    
    init(header: [String: Any], body: [String: Any]) {
        self.header = header
        self.body = body
    }
    
    private func claim(name: String) -> JWTClaim {
        let value = self.body[name]
        return JWTClaim(value: value)
    }
}
