//
//  CoreDataStore.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/03/2021.
//

import RxSwift
import CoreData

public class CoreDataStore<Entity: NSManagedObject>: LocalDataStoreProtocol {
    
    public typealias Entity = Entity
    public typealias SuccessClosure<T> = ((T?) -> Void)
    public typealias ErrorClosure = ((Error) -> Void)
    //
    private(set) var context: NSManagedObjectContext!
    
    private init() {}
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func createEntity() -> Entity {
        return Entity.init(context: self.context)
    }
    
    public func insert(record: Entity) {
        context.insert(record)
    }
    
    public func insert(records: [Entity]) {
        records.forEach { record in insert(record: record) }
    }
    
    public func insertCompletable(record: Entity) -> Completable {
        return Completable.create { [weak self] completable in
            self?.insert(record: record)
            self?.save(successClosure: { _ in 
                completable(.completed)
            }, errorClosure: { error in
                completable(.error(error))
            })
            return Disposables.create {}
        }
    }
    
    public func insertCompletable(records: [Entity]) -> Completable {
        return Completable.create { [weak self] completable in
            self?.insert(records: records)
            completable(.completed)
            return Disposables.create {}
        }
    }
    
    public func fetch(with fetchRequest: NSFetchRequest<NSFetchRequestResult>,
                      successClosure: SuccessClosure<Entity>,
                      errorClosure: ErrorClosure) {
        do {
            let result = try self.context.fetch(fetchRequest)
            if let entity = result.first as? Entity {
                successClosure(entity)
            }
            else {
                successClosure(nil)
            }
        }
        catch {
            errorClosure(error)
        }
    }
    
    public func fetchAll(successClosure: SuccessClosure<[Entity]>, errorClosure: ErrorClosure) {
        do {
            var items: [Entity] = []
            if let arrayOfItems = try self.context.fetch(self.getFetchRequest()) as? [Entity] {
                arrayOfItems.forEach { item in items.append(item) }
            }
            successClosure(items)
        }
        catch {
            errorClosure(error)
        }
    }
    
    public func fetchAll() -> Single<[Entity]> {
        return Single.create { [weak self] single in
            self?.fetchAll(successClosure: { entities in
                single(.success(entities ?? []))
            }, errorClosure: { error in
                single(.failure(error))
            })
            return Disposables.create()
        }
    }
    
    public func update(record: Entity) {
        // TODO:
    }
    
    public func delete(record: Entity) {
        self.context.delete(record)
    }
    
    public func flush() -> Completable {
        return self.fetchAll().flatMapCompletable { records -> Completable in
            do {
                for record in records {
                    let managedObjectData: NSManagedObject = record as NSManagedObject
                    self.context.delete(managedObjectData)
                }
                try self.context.save()
                return Completable.empty()
            }
            catch { return Completable.error(error) }
        }
    }
    
    func save(successClosure: SuccessClosure<Void>, errorClosure: ErrorClosure) {
        do {
            try self.context.save()
            successClosure(nil)
        }
        catch {
            errorClosure(error)
        }
    }
    
    func getFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let entityName: String = Entity.classForCoder().description()
        return NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    }
    
    func getDeleteRequest() -> NSBatchDeleteRequest {
        return NSBatchDeleteRequest(fetchRequest: getFetchRequest())
    }
}
