//
//  AppRepo.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import RxSwift
import DataModule
import CoreModule
import ServicesModule

open class AppRepo {
    
    @LazyInjected private var requestProvider: RxRequestExecuterProtocol
    
    public init() {}
    
    public func invoke(api: APIBuilder) -> Completable {
        return self.requestProvider.execute(apiRequest: api)
    }
    
    public func invoke<E: Encodable>(api: EncodableAPIBuilder<E>) -> Completable {
        return self.requestProvider.execute(apiRequest: api)
    }
    
    public func invoke<T: Decodable>(api: APIBuilder) -> Single<T> {
        let response: Single<ResponseWrapper<T>> = self.requestProvider.execute(apiRequest: api)
        return self.processAPIResult(response)
    }
    
    public func invoke<E: Encodable, T: Decodable>(api: EncodableAPIBuilder<E>) -> Single<T> {
        let response: Single<ResponseWrapper<T>> = self.requestProvider.execute(apiRequest: api)
        return self.processAPIResult(response)
    }
    
    private func processAPIResult<T: Decodable>(_ response: Single<ResponseWrapper<T>>) -> Single<T> {
        response.map { response in
            if let data = response.data {
                return data
            }
            else {
                throw ResponseWithNilContentError()
            }
        }
    }
}
