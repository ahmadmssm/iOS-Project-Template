//
//  AlamofireLogger.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Alamofire
import Foundation
import ServicesModule

open class AlamofireLogger: EventMonitor {
    
    private let loggingService: LoggingServiceProtocol
    
    init(loggingService: LoggingServiceProtocol) {
        self.loggingService = loggingService
    }
    
    public func requestDidResume(_ request: Request) {
        self.loggingService.print("🚀 Running request")
        let httpRequest = request.request
        let url = httpRequest.flatMap { $0.url?.description } ?? "No URL"
        self.loggingService.print("HTTP URL: " + url)
        let headers = httpRequest.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "No HTTP Headers"
        self.loggingService.print("HTTP Headers: " + headers)
        let method = httpRequest.flatMap { $0.method.map { $0.rawValue } } ?? "No HTTP Method"
        self.loggingService.print("HTTP Method: " + method)
        let endpoint = httpRequest?.urlRequest?.url?.absoluteURL.path ?? "No endpoint"
        self.loggingService.print("HTTP Endpoint: " + endpoint)
        self.loggingService.print("Request body: ")
        if let httpBody = httpRequest?.urlRequest?.httpBody {
            self.loggingService.print(String(decoding: httpBody, as: UTF8.self))
        }
        else {
            self.loggingService.print("No Request body")
        }
    }

    public func requestIsRetrying(_ request: Request) {
        let httpRequest = request.request
        self.loggingService.print("⚡️Retrying request")
        self.loggingService.print(httpRequest.debugDescription)
    }
    
    public func request(_ request: DataRequest, didValidateRequest urlRequest: URLRequest?, response: HTTPURLResponse, data: Data?, withResult result: Request.ValidationResult) {
        self.loggingService.print("⚡️⚡️ Response:")
        self.loggingService.prettyPrint(data)
        self.loggingService.print("⚡️⚡️ Status code: \(response.statusCode)")
        if(data != nil) {
            self.loggingService.print(data!)
        }
    }
    
    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        switch response.result {
        case .success(_):
            self.loggingService.print("⚡️ Response parsing finished successfully")
        case .failure(let error):
            self.loggingService.print("⚡️ Response parsing finished with error : \n \(String(describing: error.errorDescription))")
        }
    }
    
    public func requestDidSuspend(_ request: Request) {
        self.loggingService.print("⚡️ Request Suspended")
    }
    
    public func requestDidCancel(_ request: Request) {
        self.loggingService.print("⚡️ Request Cancelled")
    }
}
