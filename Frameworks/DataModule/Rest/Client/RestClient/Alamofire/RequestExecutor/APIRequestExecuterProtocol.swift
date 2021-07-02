//
//  APIRequestExecuterProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 11/06/2021.
//

import Alamofire

public protocol APIRequestExecuterProtocol {
    init(restConfigsProtocol: RestConfigsProtocol,
         alamofireRequestFactory: AlamofireRequestFactory)
    func isConnectedToInternet() -> Bool
    func getRequestBuilder<T: Encodable>(api: EncodableAPIBuilder<T>) -> DataRequest
    func getRequestBuilder(api: APIBuilder) -> DataRequest
    func getMultipartRequestBuilder(api: APIBuilder) -> UploadRequest
    func getDownloadRequestBuilder(api: APIBuilder, downloadDestination: @escaping DownloadRequest.Destination) -> DownloadRequest
}
