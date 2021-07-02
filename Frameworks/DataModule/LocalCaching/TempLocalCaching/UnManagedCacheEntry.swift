//
//  UnManagedCacheEntry.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 07/03/2021.
//
// Implemented NSDiscardableContent protocol to solve this issue: https://stackoverflow.com/a/52259000/6927433
// Ref: https://developer.apple.com/documentation/foundation/nsdiscardablecontent

import Foundation

final class UnManagedCacheEntry<Data>: NSDiscardableContent {
     
    let value: Data

    init(value: Data) {
        self.value = value
    }
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    // https://developer.apple.com/documentation/foundation/nsdiscardablecontent/1407535-endcontentaccess
    func endContentAccess() {
        /* Just impelemented because it is required by the `NSDiscardableContent` protocol */
    }
    
    // https://developer.apple.com/documentation/foundation/nsdiscardablecontent/1408998-discardcontentifpossible
    func discardContentIfPossible() {
        /* Just impelemented because it is required by the `NSDiscardableContent` protocol */
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
}
