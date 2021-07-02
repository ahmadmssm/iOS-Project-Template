//
//  JWTServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

public protocol JWTServiceProtocol {
    func decode(jwtToken: String) throws -> JWT
}
