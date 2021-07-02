//
//  RefreshTokenProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 23/02/2021.
//

import Alamofire
import Foundation

public protocol RefreshTokenProtocol {
    func configureRefreshTokenIfNeeded(_ urlRequest: inout URLRequest)
    func refreshToken(originalError: Error, completion: @escaping (RetryResult) -> Void)
    func retry(_ request: Request,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void)
    func shouldRefreshTokenForRequest(with response: HTTPURLResponse) -> Bool
    func isTokenExpired() -> Bool
    func shouldEnableRefreshToken() -> Bool
    func shouldRefreshTokenFirst() -> Bool
    func extractTokenFrom(data: Data) -> String?
    func createRefreshTokenRequest() -> DataRequest
}
