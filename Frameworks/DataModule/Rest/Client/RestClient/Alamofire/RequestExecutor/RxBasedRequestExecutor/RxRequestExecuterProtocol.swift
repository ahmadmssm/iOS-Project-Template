//
//  RxRequestExecuterProtocol.swift
//  Magento kernel
//
//  Created by Ahmad Mahmoud on 2/13/20.
//

import RxSwift
import Foundation

public protocol RxRequestExecuterProtocol: APIRequestExecuterProtocol {
    func execute(apiRequest: APIBuilder) -> Completable
    func execute<E: Encodable>(apiRequest: EncodableAPIBuilder<E>) -> Completable
    func execute(apiRequest: APIBuilder) -> Single<[String: Any]>
    func execute<T: Decodable>(apiRequest: APIBuilder) -> Single<T>
    func execute<E: Encodable, T: Decodable>(apiRequest: EncodableAPIBuilder<E>) -> Single<T>
}
