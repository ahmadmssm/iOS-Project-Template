//
//  AlamofireRestClient.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Alamofire
import Foundation

open class AlamofireRestClient: RestClientProtocol {
    
    // Configs related to any rest client, and not just Alamofire
    private let restConfigsProtocol: RestConfigsProtocol
    private lazy var alamofireSession = self.createAlamofireSession()
    private lazy var alamofireRequestFactory = self.createAlamofireRequestFactory()
    
    public init(restConfigsProtocol: RestConfigsProtocol) {
        self.restConfigsProtocol = restConfigsProtocol
    }
    
    // If the project requires no authentication/refresh token, then we do not need the refresh token capability.
    open func getRefreshTokenProtocol() -> RefreshTokenProtocol? {
        return nil
    }
    
    open func getAdditionalHeaders() -> [String: String] {
        return [:]
    }
    
    open func getAdditionalRequestIntercepters() -> [RequestIntercepterProtocol] {
        return []
    }
    
    public func getCurrentURLSession() -> URLSession {
        return self.alamofireSession.session
    }
    
    open func cancelRequest(withEndpoint endpoint: String) {
        self.getCurrentURLSession().getAllTasks { sessionTasks in
            for task in sessionTasks {
                if task.originalRequest?.url?.absoluteString.contains(endpoint) ?? false {
                    task.cancel()
                }
            }
        }
    }
    
    open func cancelUploadRequests() {
        self.getCurrentURLSession().getTasksWithCompletionHandler({ _, uploadTasks, _ in
            uploadTasks.forEach { $0.cancel() }
        })
    }
    
    open func cancelDownloadRequests() {
        self.getCurrentURLSession().getTasksWithCompletionHandler({ _, _, downloadTasks in
            downloadTasks.forEach { $0.cancel() }
        })
    }
    
    open func cancelAllRequests() {
        alamofireSession.session.invalidateAndCancel()
    }
    
    open func getURLSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.allowsCellularAccess = true
        return configuration
    }
    
    public func createAPIRequestExecuter<T: APIRequestExecuterProtocol>() -> T {
        return T(restConfigsProtocol: self.restConfigsProtocol,
                 alamofireRequestFactory: self.alamofireRequestFactory)
    }
    
    private func getEventMonitorsList() -> [EventMonitor] {
        var eventMonitors: [EventMonitor] = []
        eventMonitors.append(AlamofireLogger(loggingService: self.restConfigsProtocol.loggingService))
        return eventMonitors
    }
    
    private func getRequestInterceptor() -> AFRequestInterceptor? {
        let interceptor = AFRequestInterceptor()
            .set(additionalHeaders: self.getAdditionalHeaders())
            .set(additionalRequestIntercepters: getAdditionalRequestIntercepters())
            .set(refreshTokenProtocol: self.getRefreshTokenProtocol())
        return interceptor
    }
    
    private func createAlamofireSession() -> Session {
        return Session(configuration: self.getURLSessionConfiguration(),
                       interceptor: self.getRequestInterceptor(),
                       eventMonitors: self.getEventMonitorsList())
    }
    
    private func createAlamofireRequestFactory() -> AlamofireRequestFactory {
        return AlamofireRequestFactory(baseURL: self.restConfigsProtocol.baseURL,
                                       alamofireSession: self.alamofireSession)
    }
}
