//
//  AccessTokenResponse.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 12/04/2021.
//

struct AccessTokenResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let user: AppUser?
}
