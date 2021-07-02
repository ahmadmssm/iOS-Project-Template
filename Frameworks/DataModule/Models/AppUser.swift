//
//  AppUser.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

import ServicesModule

public struct AppUser: Codable, UserProtocol, Equatable {
    public let id: Int
    public var name: String
    public var phoneNumber: String
    public var email: String
    public var userId: Int { return self.id }
}
