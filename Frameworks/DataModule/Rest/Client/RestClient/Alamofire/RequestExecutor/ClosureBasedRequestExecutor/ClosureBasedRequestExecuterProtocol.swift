//
//  APIRequestProviderProtocols.swift
//  Magento kernel
//
//  Created by Ahmad Mahmoud on 2/13/20.
//

import Foundation

public protocol ClosureBasedRequestExecuterProtocol: APIRequestExecuterProtocol {
    typealias DataCompletion = (_ result: Result<Data, Error>) -> Void
    typealias GenericCompletion<T> = (_ result: Result<T, Error>) -> Void
    func execute(apiRequest: APIBuilder, completion: @escaping DataCompletion)
    func execute<E: Encodable>(apiRequest: EncodableAPIBuilder<E>, completion: @escaping DataCompletion)
    func execute<T: Decodable>(apiRequest: APIBuilder, completion: @escaping GenericCompletion<T>)
    func execute<E: Encodable, T: Decodable>(apiRequest: EncodableAPIBuilder<E>, completion: @escaping GenericCompletion<T>)
}
