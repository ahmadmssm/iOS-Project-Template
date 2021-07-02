//
//  JWTService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 08/04/2021.
//

import Foundation

public class JWTService: JWTServiceProtocol {
        
    public init() {}
    
    public func decode(jwtToken: String) throws -> JWT {
        let parts = jwtToken.components(separatedBy: ".")
        guard parts.count == 3 else {
            throw JWTError.invalidPartCount(jwtToken, parts.count)
        }
        let header = try decodeJWTPart(parts[0])
        let body = try self.decodeJWTPart(parts[1])
        // let signature = parts[2]
        return JWT(header: header, body: body)
    }
    
    private func decodeJWTPart(_ value: String) throws -> [String: Any] {
        guard let bodyData = self.base64UrlDecoder(value) else {
            throw JWTError.invalidBase64Url(value)
        }
        guard let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            throw JWTError.invalidJSON(value)
        }
        return payload
    }
    
    private func base64UrlDecoder(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 += padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
}
