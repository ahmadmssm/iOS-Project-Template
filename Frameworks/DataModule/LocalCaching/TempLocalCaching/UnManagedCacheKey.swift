//
//  UnManagedCacheKey.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/03/2021.
//

import Foundation

final class UnManagedCacheKey<Key: Hashable>: NSObject {
        
    let key: Key

    init(_ key: Key) { self.key = key }

    override var hash: Int { return key.hashValue }

    override func isEqual(_ object: Any?) -> Bool {
        guard let value = object as? UnManagedCacheKey else {
            return false
        }
        return value.key == key
    }
}
