//
//  LocalDataStoreProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 02/07/2021.
//

import RxSwift
import Foundation

public protocol LocalDataStoreProtocol {
    associatedtype Entity
    typealias SuccessClosure<T> = ((T?) -> Void)
    typealias ErrorClosure = ((Error) -> Void)
    //
    func createEntity() -> Entity
    func insert(record: Entity)
    func insert(records: [Entity])
    func insertCompletable(record: Entity) -> Completable
    func insertCompletable(records: [Entity]) -> Completable
    func fetchAll(successClosure: SuccessClosure<[Entity]>, errorClosure: ErrorClosure)
    func fetchAll() -> Single<[Entity]>
    func update(record: Entity)
    func delete(record: Entity)
    func flush() -> Completable
}
