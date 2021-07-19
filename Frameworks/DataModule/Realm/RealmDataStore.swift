//
//  RealmDataStore.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 03/07/2021.
//

import RxSwift
import RealmSwift
import CoreModule
import Foundation
import ServicesModule

public class RealmDataStore<Entity: Object>: LocalDataStoreProtocol {
    
    public typealias Entity = Entity
    
    private let loggingService: LoggingServiceProtocol
    private lazy var realm: Realm = {
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0).
        let config = Realm.Configuration(schemaVersion: UInt64(Constants.realmDBVersion))
        Realm.Configuration.defaultConfiguration = config
        do {
            return try Realm()
        }
        catch {
            fatalError("Realm error: " + error.localizedDescription)
        }
    }()
    
    public init(loggingService: LoggingServiceProtocol) {
        self.loggingService = loggingService
    }
    
    public func createEntity() -> Entity {
        fatalError()
    }
    
    public func insert(record: Entity) {
        self.insert(records: [record]) { error in
            self.loggingService.prettyPrint("Realm error: " + error.localizedDescription)
        }
    }
    
    public func insert(records: [Entity]) {
        self.insert(records: records) { error in
            self.loggingService.prettyPrint("Realm error: " + error.localizedDescription)
        }
    }
    
    public func insertCompletable(record: Entity) -> Completable {
        return Completable.create { [weak self] completable in
            self?.insert(records: [record], successAction: { _ in
                completable(.completed)
            }, errorAction: { error in
                completable(.error(error))
            })
            return Disposables.create()
        }
    }
    
    public func insertCompletable(records: [Entity]) -> Completable {
        return Completable.create { [weak self] completable in
            self?.insert(records: records, successAction: { _ in
                completable(.completed)
            }, errorAction: { error in
                completable(.error(error))
            })
            return Disposables.create()
        }
    }
    
    public func fetchAll(successClosure: ([Entity]?) -> Void, errorClosure: (Error) -> Void) {
        let results = self.realm.objects(Entity.self)
        let array = Array(results)
        successClosure(array)
    }
    
    public func fetchAll() -> Single<[Entity]> {
        return Single.create { [weak self] single in
            do {
                self?.fetchAll(successClosure: { array in
                    single(.success(array ?? []))
                }, errorClosure: { _ in
                    // No error will be thrown
                })
            }
            return Disposables.create()
        }
    }
    
    public func update(record: Entity) {
        self.update(records: [record]) { error in
            self.loggingService.prettyPrint("Realm error: " + error.localizedDescription)
        }
    }
    
    public func delete(record: Entity) {
        do {
            try self.realm.write {
                self.realm.delete(record.self)
            }
        }
        catch let error {
            self.loggingService.prettyPrint("Realm error: " + error.localizedDescription)
        }
    }
    
    public func flush() -> Completable {
        return Completable.create { completable in
            do {
                try self.realm.write {
                    let result = self.realm.objects(Entity.self)
                    self.realm.delete(result)
                    completable(.completed)
                }
            }
            catch let error { completable(.error(error)) }
            return Disposables.create()
        }
    }
    
    private func insert(records: [Entity],
                        successAction: SuccessClosure<Entity>? = nil,
                        errorAction: ErrorClosure) {
        do {
            try self.realm.write {
                if(records.count == 1) {
                    self.realm.add(records.first!)
                }
                else {
                    self.realm.add(records)
                }
                successAction?(nil)
            }
        }
        catch {
            errorAction(error)
        }
    }
    
    private func update(records: [Entity],
                        successAction: SuccessClosure<Entity>? = nil,
                        errorAction: ErrorClosure) {
        do {
            try self.realm.write {
                if(records.count == 1) {
                    self.realm.add(records.first!, update: .modified)
                }
                else {
                    self.realm.add(records, update: .modified)
                }
                successAction?(nil)
            }
        }
        catch {
            errorAction(error)
        }
    }
}
