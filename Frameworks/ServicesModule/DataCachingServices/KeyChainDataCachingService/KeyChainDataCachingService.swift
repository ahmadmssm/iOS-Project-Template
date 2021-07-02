//
//  KeyChainDataCachingService.swift
//  ServicesModule
//
//  Created by Ahmad Mahmoud on 14/06/2021.
//
// Reg: https://github.com/kishikawakatsumi/KeychainAccess

import Foundation

open class KeyChainDataCachingService: DataCachingServiceProtocol {
    
    private let keychain: KeychainSwift
    private let loggingService: LoggingServiceProtocol
    private let serializationService: SerializationServiceProtocol
    
    public init(loggingService: LoggingServiceProtocol, serializationService: SerializationServiceProtocol) {
        self.keychain = KeychainSwift()
        self.loggingService = loggingService
        self.serializationService = serializationService
    }
    
    public func boolean(value: Bool, key: String) {
        self.keychain.set(value, forKey: key)
    }
    
    public func string(value: String, key: String) {
        self.keychain.set(value, forKey: key)
    }
    
    public func int(value: Int, key: String) {
        self.keychain.set(String(value), forKey: key)
    }
    
    public func double(value: Double, key: String) {
        self.keychain.set(String(value), forKey: key)
    }
    
    public func data(value: Data, key: String) {
        self.keychain.set(value, forKey: key)
    }
    
    public func object<T: Codable>(value: T, key: String) {
        if let jsonString = self.serializationService.objectToJSONString(obj: value) {
            self.string(value: jsonString, key: key)
        }
        else {
            self.loggingService.print("Could not save \(value)")
        }
    }
    
    public func arrayOfObjects<T: Codable>(value: [T], key: String) {
        fatalError("Not Implemented")
    }
    
    public func array(value: [Any], key: String) {
        fatalError("Not Implemented")
    }
    
    public func get(key: String) -> Bool {
        return self.keychain.getBool(key) ?? false
    }
    
    public func get(key: String) -> String? {
        return self.keychain.get(key)
    }
    
    public func get(key: String) -> Int {
        if let intDescription: String = self.get(key: key) {
            return Int(intDescription) ?? -1
        }
        return -1
    }
    
    public func get(key: String) -> Double {
        if let doubleDescription: String = self.get(key: key) {
            return Double(doubleDescription) ?? 0.0
        }
        return 0.0
    }
    
    public func get(key: String) -> Data? {
        return self.keychain.getData(key)
    }
    
    public func get(key: String) -> Any? {
        fatalError("Not Implemented")
    }
    
    public func getArray(key: String) -> [Any]? {
        fatalError("Not Implemented")
    }
    
    public func get<T: Codable>(key: String) -> T? {
        if let data: Data = self.get(key: key), let clazz = self.serializationService.objectFrom(data: data, type: T.self) {
            return clazz
        }
        return nil
    }
    
    public func getArray<T: Codable>(key: String) -> [T]? {
        fatalError("Not Implemented")
        
    }
    
    public func hasValue(for key: String) -> Bool {
        return self.keychain.allKeys.contains(key)
    }
    
    public func deleteValueWithKey(key: String) {
        self.keychain.delete(key)
    }
    
    public func clear() {
        self.keychain.allKeys.forEach { key in
            self.deleteValueWithKey(key: key)
        }
    }
}
