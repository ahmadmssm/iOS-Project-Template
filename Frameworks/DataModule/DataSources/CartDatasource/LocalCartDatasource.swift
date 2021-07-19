////
////  LocalCartDatasource.swift
////  DataModule
////
////  Created by Ahmad Mahmoud on 18/03/2021.
////
//
//import RxSwift
//import CoreData
//import ServicesModule
//
//public class LocalCartDatasource: CoreDataStore<DishEntity>, CartDataSource {
//
//    private let serializationService: SerializationServiceProtocol
//
//    public init(context: NSManagedObjectContext, serializationService: SerializationServiceProtocol) {
//        self.serializationService = serializationService
//        super.init(context: context)
//    }
//
//    private func objectToData<T: Encodable>(obj: T) -> Data? {
//        return serializationService.objectToData(obj: obj)
//    }
//
//    private func dataToObject<T: Decodable>(data: Data?, type: T.Type) -> T? {
//        return serializationService.objectFrom(data: data, type: type)
//    }
//}
