//
//  RestClientProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 11/06/2021.
//

import Foundation

public protocol RestClientProtocol {
    func getRefreshTokenProtocol() -> RefreshTokenProtocol?
    func getAdditionalRequestIntercepters() -> [RequestIntercepterProtocol]
    func getURLSessionConfiguration() -> URLSessionConfiguration
    func getCurrentURLSession() -> URLSession
    func getAdditionalHeaders() -> [String: String]
    func cancelRequest(withEndpoint endpoint: String)
    func cancelUploadRequests()
    func cancelDownloadRequests()
    func cancelAllRequests()
}
