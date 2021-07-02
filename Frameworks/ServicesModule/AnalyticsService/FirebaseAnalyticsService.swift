//
//  FirebaseAnalyticsService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 05/05/2021.
//

import Firebase

public class FirebaseAnalyticsService: AnalyticsServiceProtocol {
    
    public var strategy: AnalyticsStrategy = .firebase
    
    required public init () {
        Analytics.setAnalyticsCollectionEnabled(self.enableLogging())
    }
    
    public func enableLogging() -> Bool {
        return true
    }
    
    public func log(event: AnalyticsEvents) {
        self.doIfEnabled {
            Analytics.logEvent(event.rawValue, parameters: nil)
        }
    }
    
    public func log(userId: Int) {
        self.doIfEnabled {
            Analytics.setUserID(String(userId))
        }
    }
    
    public func log(event: AnalyticsEvents, params: [String: Any]) {
        self.doIfEnabled {
            Analytics.logEvent(event.rawValue, parameters: params)
        }
    }
}
