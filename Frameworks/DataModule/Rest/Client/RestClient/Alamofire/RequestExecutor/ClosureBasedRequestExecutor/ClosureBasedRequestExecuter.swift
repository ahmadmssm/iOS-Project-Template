//
//  ClosureBasedRequestExecuter.swift
//  Magento kernel
//
//  Created by Ahmad Mahmoud on 2/13/20.
//

import Foundation
import Alamofire
import ServicesModule

public class ClosureBasedRequestExecuter: ClosureBasedRequestExecuterProtocol {
    
    private let baseURL: String
    private let jsonDecoder: JSONDecoder
    private let loggingService: LoggingServiceProtocol
    private let connectivityService: InternetConnectivityServiceProtocol
    private let alamofireRequestFactory: AlamofireRequestFactory
    private lazy var noInternetConnectionError = NoInternetConnectionError()
    
    required public init(restConfigsProtocol: RestConfigsProtocol, alamofireRequestFactory: AlamofireRequestFactory) {
        self.baseURL = restConfigsProtocol.baseURL
        self.loggingService = restConfigsProtocol.loggingService
        self.connectivityService = restConfigsProtocol.connectivityService
        self.jsonDecoder = restConfigsProtocol.serializationService.getJSONDecoder()
        self.alamofireRequestFactory = alamofireRequestFactory
    }
    
    open func isConnectedToInternet() -> Bool {
        return self.connectivityService.isInternetConnectionAvailable()
    }
    
    open func execute(apiRequest: APIBuilder, completion: @escaping DataCompletion) {
        self.doIfConnected({
            self.getRequestBuilder(api: apiRequest).responseData { [weak self] response in
                guard let self = self else { return }
                self.processResponse(response: response, completion: completion)
            }
        }, completion: completion)
    }
    
    open func execute<E: Encodable>(apiRequest: EncodableAPIBuilder<E>, completion: @escaping DataCompletion) {
        self.doIfConnected({
            self.getRequestBuilder(api: apiRequest).responseData { [weak self] response in
                guard let self = self else { return }
                self.processResponse(response: response, completion: completion)
            }
        }, completion: completion)
    }
    
    open func execute<T: Decodable>(apiRequest: APIBuilder, completion: @escaping GenericCompletion<T>) {
        self.doIfConnected({
            self.getRequestBuilder(api: apiRequest).responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] response in
                guard let self = self else { return }
                self.processDecodableResponse(response: response, completion: completion)
            }
        }, completion: completion)
    }
    
    open func execute<E: Encodable, T: Decodable>(apiRequest: EncodableAPIBuilder<E>, completion: @escaping GenericCompletion<T>) {
        self.doIfConnected({
            self.getRequestBuilder(api: apiRequest).responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] response in
                guard let self = self else { return }
                self.processDecodableResponse(response: response, completion: completion)
            }
        }, completion: completion)
    }
    
    private func logError(error: AFError) {
        switch error {
        case .responseValidationFailed(let reason):
            self.loggingService.print("Response validation failed: \(error.localizedDescription)")
            self.loggingService.print("Failure Reason: \(reason)")
        case .responseSerializationFailed(let reason):
            self.loggingService.print("Response serialization failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        default:
            self.loggingService.print("Failure Reason: \(error.localizedDescription)")
        }
    }
    
    private func doIfConnected<T: Decodable>(_ action: (() -> Void), completion: @escaping GenericCompletion<T>) {
        guard  self.isConnectedToInternet() else {
            completion(.failure(self.noInternetConnectionError))
            return
        }
        action()
    }
    
    private func processResponse(response: DataResponse<Data, AFError>, completion: @escaping DataCompletion) {
        switch response.result {
        case .success(let responseObject):
            completion(Result.success(responseObject))
        case .failure(let error):
            self.logError(error: error)
            let originalRequest = response.request
            // If there is a status code then this is a server error
            if let statusCode = response.response?.statusCode {
                let customError = self.createServerTypeError(response.error!,
                                                             response.data,
                                                             statusCode,
                                                             originalRequest)
                completion(Result.failure(customError))
            }
            else {
                self.logError(error: error)
                completion(Result.failure(self.createAlamofireTypeError(error)))
            }
        }
    }
    
    private func processDecodableResponse<T: Decodable>(response: DataResponse<T, AFError>, completion: @escaping GenericCompletion<T>) {
        switch response.result {
        case .success(let responseObject):
            completion(Result.success(responseObject))
        case .failure(let error):
            self.logError(error: error)
            let originalRequest = response.request
            // If there is a status code then this is a server error
            if let statusCode = response.response?.statusCode {
                let customError = self.createServerTypeError(response.error!,
                                                             response.data,
                                                             statusCode,
                                                             originalRequest)
                completion(Result.failure(customError))
            }
            else {
                self.logError(error: error)
                completion(Result.failure(self.createAlamofireTypeError(error)))
            }
        }
    }
    
    private func createServerTypeError(_ error: AFError,
                                       _ errorData: Data?,
                                       _ statusCode: Int,
                                       _ request: URLRequest?) -> AlamofireError {
        return AlamofireError.serverError(error, errorData, statusCode, request)
    }
    
    private func createAlamofireTypeError(_ originalError: AFError) -> AlamofireError {
        return AlamofireError.alamofireError(originalError: originalError)
    }
    
    open func getRequestBuilder<T: Encodable>(api: EncodableAPIBuilder<T>) -> DataRequest {
        return self.alamofireRequestFactory.createRequestWith(api: api)
    }
    
    open func getRequestBuilder(api: APIBuilder) -> DataRequest {
        return self.alamofireRequestFactory.createRequestWith(api: api)
    }
    
    open func getMultipartRequestBuilder(api: APIBuilder) -> UploadRequest {
        return self.alamofireRequestFactory.createUploadRequest(baseURL: self.baseURL,
                                                                api: api)
    }
    
    // https://stackoverflow.com/questions/41136560/setting-alamofire-custom-destination-file-name-instead-of-using-suggesteddownloa
    open func getDownloadRequestBuilder(api: APIBuilder,
                                        downloadDestination: @escaping DownloadRequest.Destination) -> DownloadRequest {
        return self.alamofireRequestFactory.createDownloadRequest(baseURL: self.baseURL,
                                                                  api: api,
                                                                  downloadDestination: downloadDestination)
    }
}
