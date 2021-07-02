//
//  RemoteLoggingService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 05/05/2021.
//

import FirebaseCrashlytics

public class RemoteLoggingService: RemoteLoggingServiceProtocol {
    
    private let crashlytics = Crashlytics.crashlytics()
    
    public func log(userId: Int) {
        self.crashlytics.setUserID(String(userId))
    }
    
    public func log(message: String) {
        self.crashlytics.log(message)
    }
    
    public func log(error: Error) {
        self.crashlytics.record(error: error)
    }
    
    public func log(value: Any, key: String) {
        self.crashlytics.setCustomValue(value, forKey: key)
    }
    
    public func log(KeysAndValues: [String: Any]) {
        self.crashlytics.setCustomKeysAndValues(KeysAndValues)
    }
}
