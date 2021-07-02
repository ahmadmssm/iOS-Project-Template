//
//  AlamofireRequestFactory.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/02/2021.
//

import Alamofire

public class AlamofireRequestFactory {
    
    private let baseURL: String
    private let alamofireSession: Alamofire.Session
    
    init(baseURL: String, alamofireSession: Alamofire.Session) {
        self.baseURL = baseURL
        self.alamofireSession = alamofireSession
    }
    
    func createRequestWith(api: APIBuilder) -> DataRequest {
        let fullURL = (baseURL + api.route.path)
        let method = api.route.method
        let headers = self.createAlamofireHttpHeadersFrom(dictionary: api.headers)
        let parameters =  api.params
        let encoding = api.encoding
        let dataRequest = alamofireSession.request(fullURL,
                                                   method: method,
                                                   parameters: parameters,
                                                   encoding: encoding,
                                                   headers: headers)
        return dataRequest.validate(statusCode: 200..<300)
    }
    
    func createRequestWith<T>(api: EncodableAPIBuilder<T>) -> DataRequest {
        let fullURL = (baseURL + api.route.path)
        let method = api.route.method
        let headers = self.createAlamofireHttpHeadersFrom(dictionary: api.headers)
        let parameters =  api.params
        let encoding = api.encoding
        let dataRequest = alamofireSession.request(fullURL,
                                                   method: method,
                                                   parameters: parameters,
                                                   encoder: encoding,
                                                   headers: headers)
        return dataRequest.validate(statusCode: 200..<300)
    }
    
    func createUploadRequest(baseURL: String, api: APIBuilder) -> UploadRequest {
        let fullURL = (baseURL + api.route.path)
        let method = api.route.method
        let headers = self.createAlamofireHttpHeadersFrom(dictionary: api.headers)
        let formDataDictionary = api.params ?? [:]
        let uploadRequest = self.alamofireSession.upload(multipartFormData: { multipartFormData in
            multipartFormData.from(dictionary: formDataDictionary)
        }, to: fullURL, method: method, headers: headers)
        return uploadRequest.validate(statusCode: 200..<300)
    }
    
    func createDownloadRequest(baseURL: String,
                               api: APIBuilder,
                               downloadDestination: @escaping DownloadRequest.Destination) -> DownloadRequest {
        let fullURL = (baseURL + api.route.path)
        let method = api.route.method
        let headers = self.createAlamofireHttpHeadersFrom(dictionary: api.headers)
        let parameters = api.params ?? [:]
        let encoding = api.encoding 
        let downloadRequest = self.alamofireSession.download(fullURL,
                                                             method: method,
                                                             parameters: parameters,
                                                             encoding: encoding,
                                                             headers: headers,
                                                             to: downloadDestination)
        return downloadRequest.validate(statusCode: 200..<300)
    }
    
    func createAlamofireHttpHeadersFrom(dictionary: [String: String]) -> HTTPHeaders {
        var header: HTTPHeader?
        var headersArray: [HTTPHeader] = []
        dictionary.forEach { args in
            header = HTTPHeader(name: args.key, value: args.value)
            headersArray.append(header!)
        }
        return HTTPHeaders(headersArray)
    }
}
