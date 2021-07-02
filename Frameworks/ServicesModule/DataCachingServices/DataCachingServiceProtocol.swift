//
//  DataCachingServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import Foundation

public protocol DataCachingServiceProtocol {
    func boolean(value: Bool, key: String)
    func string(value: String, key: String)
    func int(value: Int, key: String)
    func double(value: Double, key: String)
    func data(value: Data, key: String)
    func object<T: Codable>(value: T, key: String)
    func arrayOfObjects<T: Codable>(value: [T], key: String)
    func array(value: [Any], key: String)
    //
    func get(key: String) -> Bool
    func get(key: String) -> String?
    func get(key: String) -> Int
    func get(key: String) -> Double
    func get(key: String) -> Data?
    func get(key: String) -> Any?
    func getArray(key: String) -> [Any]?
    func get<T: Codable>(key: String) -> T?
    func getArray<T: Codable>(key: String) -> [T]?
    //
    func hasValue(for key: String) -> Bool
    func deleteValueWithKey(key: String)
    func clear()
}
