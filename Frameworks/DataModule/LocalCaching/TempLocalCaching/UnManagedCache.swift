//
//  UnManagedCache.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/03/2021.
//

import Foundation
import ServicesModule

/*
 This class is used for unmanaged caching, i.e: simple caching (Just add or remove all, no item update is needed), also caching while the app is running and is evicted once the App is closed.
 */
public class UnManagedCache<Key: Hashable> {
    
    private let serializationService: SerializationServiceProtocol
    private let cache = NSCache<UnManagedCacheKey<Key>, UnManagedCacheEntry<Data>>()
    
    public init(serializationService: SerializationServiceProtocol) {
        self.serializationService = serializationService
    }
    
    func insert<T: Codable>(_ value: T, forKey key: Key) {
        if let data = self.serializationService.objectToData(obj: value) {
            let entry = UnManagedCacheEntry(value: data)
            self.cache.setObject(entry, forKey: self.getKey(key: key))
        }
    }
    
    func getValue<T: Codable>(forKey key: Key, type: T.Type) -> T? {
        let entry = self.cache.object(forKey: self.getKey(key: key))
        if let data = entry?.value {
            return self.serializationService.objectFrom(data: data, type: type.self)
        }
        return nil
    }
    
    func removeValue(forKey key: Key) {
        self.cache.removeObject(forKey: self.getKey(key: key))
    }
    
    private func getKey(key: Key) -> UnManagedCacheKey<Key> {
        UnManagedCacheKey(key)
    }
}
