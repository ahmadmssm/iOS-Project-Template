//
//  SessionServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Foundation

public protocol SessionServiceProtocol {
    func isGuestUser() -> Bool
    func hasValidUser() -> Bool
    func hasValidSession() -> Bool
    func shouldRetryWithAuthentication() -> Bool
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func getUserId() -> Int
    func getUser<T: UserProtocol>() -> T?
    func save(accessToken: String)
    func save(refreshToken: String)
    func save(userId: Int)
    func save<T: UserProtocol>(user: T)
    func save<T: UserProtocol>(user: T, accessToken: String, refreshToken: String)
    func removeSession()
}
