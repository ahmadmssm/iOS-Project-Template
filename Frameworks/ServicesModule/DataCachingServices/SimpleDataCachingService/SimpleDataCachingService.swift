//
//  SimpleDataCachingService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import Foundation

public class SimpleDataCachingService: DataCachingServiceProtocol {
   
    private let loggingService: LoggingServiceProtocol
    private let serializationService: SerializationServiceProtocol
    private let userDefaults = UserDefaults.standard

    public init(loggingService: LoggingServiceProtocol, serializationService: SerializationServiceProtocol) {
        self.loggingService = loggingService
        self.serializationService = serializationService
    }

    public func boolean(value: Bool, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func string(value: String, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func int(value: Int, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func double(value: Double, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func data(value: Data, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func object<T: Codable>(value: T, key: String) {
        if let jsonString = self.serializationService.objectToJSONString(obj: value) {
            self.string(value: jsonString, key: key)
        }
        else {
            self.loggingService.print("Could not save \(value) with key \(key)")
        }
    }
    
    public func arrayOfObjects<T: Codable>(value: [T], key: String) {
        self.object(value: value, key: key)
    }
    
    public func array(value: [Any], key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func get(key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    public func get(key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    public func get(key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    public func get(key: String) -> Double {
        return userDefaults.double(forKey: key)
    }
    
    public func get(key: String) -> Data? {
        return userDefaults.value(forKey: key) as? Data
    }
    
    public func get<T: Codable>(key: String) -> T? {
        if let jsonString: String = self.get(key: key) {
            return self.serializationService.objectFrom(string: jsonString, type: T.self)
        }
        self.loggingService.print("Could not retrieve value for key \(key)")
        return nil
    }
    
    public func get(key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
    
    public func getArray<T: Codable>(key: String) -> [T]? {
        if let jsonString: String = self.get(key: key) {
            return self.serializationService.objectFrom(string: jsonString, type: [T].self)
        }
        self.loggingService.print("Could not retrieve value key)")
        return nil
    }
    
    public func getArray(key: String) -> [Any]? {
        return userDefaults.array(forKey: key)
    }
    
    public func hasValue(for key: String) -> Bool {
        return self.get(key: key) as Any? != nil
    }
    
    public func deleteValueWithKey(key: String) {
        self.userDefaults.removeObject(forKey: key)
        self.userDefaults.synchronize()
    }
    
    public func clear() {
        self.userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        self.userDefaults.synchronize()
    }
}
