//
//  RealmDataStoreProtocol.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 03/07/2021.
//

import RxSwift
import Foundation

protocol RealmDataStoreProtocol: LocalDataStoreProtocol {
    func updateRecord(with predicate: NSPredicate)
    func updateRecordCompletable(with predicate: NSPredicate) -> Completable
    func updateRecords(records: [Entity])
    func updateRecordsCompletable(records: [Entity]) -> Completable
    func deleteRecord(with predicate: NSPredicate)
    func deleteRecordCompletable(with predicate: NSPredicate) -> Completable
    func deleteRecords(records: [Entity])
    func deleteRecordsCompletable(records: [Entity]) -> Completable
    func deleteAllRecordsCompletable(forObject: Entity.Type) -> Completable
    func fetchRecordsPerPage(perPage: Int, page: Int, filterBy: String) -> [Entity]
    func fetchRecordsPerPageSingle(perPage: Int, page: Int, filterBy: String) -> Single<[Entity]>
    func fetchRecordsPerPage(perPage: Int, page: Int) -> [Entity]
    func fetchRecordsPerPageSingle(perPage: Int, page: Int) -> Single<[Entity]>
}
