//
//  DiffableItem.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 21/06/2021.
//

public protocol DiffableItem: Hashable {
    var uniqueId: Int { get }
}

public extension DiffableItem {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }
}
