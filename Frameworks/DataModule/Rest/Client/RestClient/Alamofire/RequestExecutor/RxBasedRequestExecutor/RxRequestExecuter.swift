//
//  RxRequestExecuter.swift
//  Magento kernel
//
//  Created by Ahmad Mahmoud on 2/13/20.
//

import RxSwift
import Foundation
import ServicesModule

public class RxRequestExecuter: ClosureBasedRequestExecuter, RxRequestExecuterProtocol {
    
    private let serializationService: SerializationServiceProtocol
    
    public required init(restConfigsProtocol: RestConfigsProtocol, alamofireRequestFactory: AlamofireRequestFactory) {
        self.serializationService = restConfigsProtocol.serializationService
        super.init(restConfigsProtocol: restConfigsProtocol, alamofireRequestFactory: alamofireRequestFactory)
    }
    
    public func execute(apiRequest: APIBuilder) -> Completable {
        return Completable.create { [weak self] completable -> Disposable in
            /*
             Used If - let - else instead of guard let to avoid writing
             this line `return Disposables.create()` twice, one time inside the else branch of the guard
             and the other time at the end of the success branch.
             */
            if let self = self {
                self.execute(apiRequest: apiRequest) { (result: Result<Data, Error>) in
                    switch result {
                    case .success(_):
                        completable(.completed)
                    case .failure(let error):
                        self.doOnError(error) { processedError in
                            completable(.error(processedError))
                        }
                    }
                }
            }
            else {
                completable(.error(UnKnownError()))
            }
            return Disposables.create()
        }
        // All the requests will be done on the background thread by default -> subscribe(on),
        // And the result will be on the UI thread.
        .subscribe(on: RxSchedulers.workerThread)
        .observe(on: RxSchedulers.mainThread)
    }
    
    public func execute<E: Encodable>(apiRequest: EncodableAPIBuilder<E>) -> Completable {
        return Completable.create { [weak self] completable -> Disposable in
            /*
             Used If - let - else instead of guard let to avoid writing
             this line `return Disposables.create()` twice, one time inside the else branch of the guard
             and the other time at the end of the success branch.
             */
            if let self = self {
                self.execute(apiRequest: apiRequest) { (result: Result<Data, Error>) in
                    switch result {
                    case .success(_):
                        completable(.completed)
                    case .failure(let error):
                        self.doOnError(error) { processedError in
                            completable(.error(processedError))
                        }
                    }
                }
            }
            else {
                completable(.error(UnKnownError()))
            }
            return Disposables.create()
        }
        // All the requests will be done on the background thread by default -> subscribe(on),
        // And the result will be on the UI thread.
        .subscribe(on: RxSchedulers.workerThread)
        .observe(on: RxSchedulers.mainThread)
    }
    
    open func execute<T: Decodable>(apiRequest: APIBuilder) -> Single<T> {
        return Single.create { [weak self] single -> Disposable in
            /*
             Used If - let - else instead of guard let to avoid writing
             this line `return Disposables.create()` twice, one time inside the else branch of the guard
             and the other time at the end of the success branch.
             */
            if let self = self {
                self.execute(apiRequest: apiRequest) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        self.doOnError(error) { processedError in
                            single(.failure(processedError))
                        }
                    }
                }
            }
            else {
                single(.failure(UnKnownError()))
            }
            return Disposables.create()
        }
        // All the requests will be done on the background thread by default -> subscribe(on),
        // And the result will be on the UI thread.
        .subscribe(on: RxSchedulers.workerThread)
        .observe(on: RxSchedulers.mainThread)
    }
    
    open func execute<E, T>(apiRequest: EncodableAPIBuilder<E>) -> Single<T> where E: Encodable, T: Decodable {
        return Single.create { [weak self] single -> Disposable in
            /*
             Used If - let - else instead of guard let to avoid writing
             this line `return Disposables.create()` twice, one time inside the else branch of the guard.
             and the other time at the end of the success branch.
             */
            if let self = self {
                self.execute(apiRequest: apiRequest) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        self.doOnError(error) { processedError in
                            single(.failure(processedError))
                        }
                    }
                }
            }
            else {
                single(.failure(UnKnownError()))
            }
            return Disposables.create()
        }
        // All the requests will be done on the background thread by default -> subscribe(on),
        // And the result will be on the UI thread.
        .subscribe(on: RxSchedulers.workerThread)
        .observe(on: RxSchedulers.mainThread)
    }
    
    private func doOnError<T>(_ error: Error, action: (Error) -> (T)) -> T {
        if case let AlamofireError.serverError(_, errorData, statusCode, _) = error {
            if 500 ... 599 ~= statusCode {
                return action(UnKnownError())
            }
            if let apiError = self.serializationService.objectFrom(data: errorData, type: APIError.self), statusCode == 422 {
                if let formErrors = apiError.formErrors, !formErrors.isEmpty {
                    return action(apiError.createFormError())
                }
                else {
                    return action(apiError.createSimpleError())
                }
            }
        }
        return action(error)
    }
}
