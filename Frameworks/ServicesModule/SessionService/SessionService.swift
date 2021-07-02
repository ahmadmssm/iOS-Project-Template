//
//  SessionService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import Foundation

public class SessionService: SessionServiceProtocol {
    
    private let serializationService: SerializationServiceProtocol
    private let simpleDataCachingService: DataCachingServiceProtocol
    
    enum SessionKeys: String {
        case savedUser
        case savedUserId
        case savedSession
        case savedAccessToken
    }
    
    public init(serializationService: SerializationServiceProtocol,
                simpleDataCachingService: DataCachingServiceProtocol) {
        self.serializationService = serializationService
        self.simpleDataCachingService = simpleDataCachingService
    }
    
    public func isGuestUser() -> Bool {
        return !self.hasValidUser()
    }
    
    public func hasValidUser() -> Bool {
        return self.simpleDataCachingService.hasValue(for: SessionKeys.savedUser.rawValue)
    }
    
    public func hasValidSession() -> Bool {
        let hasAccessToken = self.getAccessToken() != nil ? true : false
        if(hasAccessToken && self.hasValidUser()) {
            return true
        }
        return false
    }
    
    public func shouldRetryWithAuthentication() -> Bool {
        self.hasValidUser() && self.hasValidSession()
    }
    
    public func getAccessToken() -> String? {
        self.simpleDataCachingService.get(key: SessionKeys.savedAccessToken.rawValue)
    }
    
    public func getRefreshToken() -> String? {
        // Refresh token is not used in the project
        return self.getAccessToken()
    }
    
    public func getUserId() -> Int {
        if let userId: Int = self.simpleDataCachingService.get(key: SessionKeys.savedUserId.rawValue) {
            return userId
        }
        fatalError("User Id is not found, User must be logged in!")
    }
    
    public func getUser<T>() -> T? where T: UserProtocol {
        self.simpleDataCachingService.get(key: SessionKeys.savedUser.rawValue)
    }
    
    public func save(accessToken: String) {
        self.simpleDataCachingService.string(value: accessToken, key: SessionKeys.savedAccessToken.rawValue)
    }
    
    public func save(refreshToken: String) {
        // Refresh token is not used in the project
        self.save(accessToken: refreshToken)
    }
    
    public func save(userId: Int) {
        self.simpleDataCachingService.int(value: userId, key: SessionKeys.savedUserId.rawValue)
    }
    
    public func save<T>(user: T) where T: UserProtocol {
        self.save(userId: user.userId)
        self.simpleDataCachingService.object(value: user, key: SessionKeys.savedUser.rawValue)
    }
    
    public func save<T>(user: T, accessToken: String, refreshToken: String) where T: UserProtocol {
        self.save(user: user)
        self.save(userId: user.userId)
        self.save(accessToken: accessToken)
        self.save(refreshToken: refreshToken)
    }
    
    public func removeSession() {
        self.deleteValueWith(key: .savedUser)
        self.deleteValueWith(key: .savedUserId)
        self.deleteValueWith(key: .savedAccessToken)
    }
    
    private func deleteValueWith(key: SessionKeys) {
        self.simpleDataCachingService.deleteValueWithKey(key: key.rawValue)
    }
}
