//
//  AFRequestInterceptor.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/02/2021.
//
//  Ref: https://www.avanderlee.com/swift/authentication-alamofire-request-adapter/
//

import Alamofire
import Foundation

open class AFRequestInterceptor: Alamofire.RequestInterceptor {
    
    public var baseURL: String?
    private var isFirstTime = true
    private var refreshTokenProtocol: RefreshTokenProtocol?
    private var additionalHeaders: [String: String]?
    private var requestIntercepters: [RequestIntercepterProtocol]?
    
    func set(refreshTokenProtocol: RefreshTokenProtocol?) -> Self {
        self.refreshTokenProtocol = refreshTokenProtocol
        return self
    }
    
    func set(additionalHeaders: [String: String]) -> Self {
        self.additionalHeaders = additionalHeaders
        return self
    }
    
    func set(additionalRequestIntercepters: [RequestIntercepterProtocol]) -> Self {
        self.requestIntercepters = additionalRequestIntercepters
        return self
    }
    
    open func getModifiedURLRequest(_ urlRequest: URLRequest) -> URLRequest {
        var request = urlRequest
        self.refreshTokenProtocol?.configureRefreshTokenIfNeeded(&request)
        self.appendAdditionalHeaders(&request)
        self.appendAdditionalIntercepters(&request)
        return request
    }
    
    open func appendAdditionalHeaders(_ urlRequest: inout URLRequest) {
        if (!(additionalHeaders?.isEmpty ?? true)) {
            additionalHeaders?.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
    
    open func appendAdditionalIntercepters(_ urlRequest: inout URLRequest) {
        var request = urlRequest
        if (!(requestIntercepters?.isEmpty ?? true)) {
            requestIntercepters?.forEach { requestIntercepter in
                requestIntercepter.modifyURLRequest(&request)
            }
        }
        urlRequest = request
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if (self.isFirstTime) {
            self.isFirstTime = false
            self.baseURL = urlRequest.url?.baseURL?.absoluteString
        }
        completion(.success(getModifiedURLRequest(urlRequest)))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        self.refreshTokenProtocol?.retry(request, dueTo: error, completion: completion)
    }
}
