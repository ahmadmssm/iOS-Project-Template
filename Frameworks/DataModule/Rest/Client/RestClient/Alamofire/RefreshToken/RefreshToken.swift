//
//  RefreshToken.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 23/02/2021.
//

import Alamofire
import Foundation
import ServicesModule

public class RefreshToken: RefreshTokenProtocol {
    
    private let lock: NSLock
    private let jwtService: JWTServiceProtocol
    private let loggingService: LoggingServiceProtocol
    private let sessionService: SessionServiceProtocol
    private let serializationService: SerializationServiceProtocol
    private let baseURL: String
    private var isRefreshing = false
    private lazy var refreshTokenAlamofireSession = self.createRefreshTokenSession()
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    public init(baseURL: String,
                jwtService: JWTServiceProtocol,
                sessionService: SessionServiceProtocol,
                serializationService: SerializationServiceProtocol,
                loggingService: LoggingServiceProtocol) {
        self.baseURL = baseURL
        self.lock = NSLock()
        self.jwtService = jwtService
        self.sessionService = sessionService
        self.loggingService = loggingService
        self.serializationService = serializationService
    }
    
    open func configureRefreshTokenIfNeeded(_ urlRequest: inout URLRequest) {
        if (self.sessionService.hasValidSession()) {
            let token = self.sessionService.getAccessToken()!
            urlRequest.headers.add(.authorization(bearerToken: token))
        }
    }
    
    // https://stackoverflow.com/a/56965479/6927433
    open func refreshToken(originalError: Error, completion: @escaping (RetryResult) -> Void) {
        guard !self.isRefreshing else { return }
        self.lock.lock() ; defer { self.lock.unlock() }
        self.isRefreshing = true
        self.createRefreshTokenRequest()
            .validate(statusCode: 200..<300)
            .responseJSON(queue: .global(qos: .background)) { [weak self] response in
                guard let self = self else { return }
                self.lock.lock(); defer { self.lock.unlock() }
                if let data = response.data, let token = self.extractTokenFrom(data: data), !token.isEmpty {
                    self.sessionService.save(accessToken: token)
                    self.loggingService.print("\nRefresh token completed successfully. \nNew token is: \(token)\n")
                    // After updating the token we can safely retry the original request.
                    // Retry every request if there were many concurrent requests
                    self.requestsToRetry.forEach { $0(.retry) }
                    self.requestsToRetry.removeAll()
                }
                else {
                    let error = RefreshTokenError(originalRequestError: originalError)
                    completion(.doNotRetryWithError(error))
                }
                self.isRefreshing = false
            }
    }
    
    open func retry(_ request: Request, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if (self.shouldEnableRefreshToken()) {
            guard let response = request.task?.response as? HTTPURLResponse,
                  self.shouldRefreshTokenForRequest(with: response) else {
                // Return the original error and don't retry the request.
                return completion(.doNotRetryWithError(error))
            }
            self.requestsToRetry.append(completion)
            self.refreshToken(originalError: error, completion: completion)
        }
        else {
            return completion(.doNotRetryWithError(error))
        }
    }
    
    open func shouldRefreshTokenForRequest(with response: HTTPURLResponse) -> Bool {
        // The request did fail due to a 401 Unauthorized response.
        return response.statusCode == 401
    }
    
    open func isTokenExpired() -> Bool {
        if let token = self.sessionService.getRefreshToken() {
            do {
                return try self.jwtService.decode(jwtToken: token).expired
            }
            catch {
                self.loggingService.prettyPrint("Token decoding Error \(error)")
            }
        }
        return true
    }
    
    public func shouldEnableRefreshToken() -> Bool {
        return self.sessionService.shouldRetryWithAuthentication()
    }
    
    public func shouldRefreshTokenFirst() -> Bool {
        return self.shouldEnableRefreshToken() && self.isTokenExpired() == true
    }
    
    public func extractTokenFrom(data: Data) -> String? {
        return self
            .serializationService
            .objectFrom(data: data, type: ResponseWrapper<AccessTokenResponse>.self)
            .map { ($0.data?.accessToken ?? "") }
    }
    
    public func createRefreshTokenRequest() -> DataRequest {
        let oldToken = self.sessionService.getAccessToken()
        let refreshTokenRequest = RefreshTokenRequest.create(oldToken: oldToken)
        let fullURL = self.baseURL + refreshTokenRequest.endPoint
        let parameters = refreshTokenRequest.parameters
        let encoding = refreshTokenRequest.encoding
        let headers = refreshTokenRequest.headers
        return refreshTokenAlamofireSession.request(fullURL,
                                                    method: .post,
                                                    parameters: parameters,
                                                    encoding: encoding,
                                                    headers: headers)
    }
    
    private func createRefreshTokenSession() -> Session {
        return Session(eventMonitors: [AlamofireLogger(loggingService: loggingService)])
    }
}
