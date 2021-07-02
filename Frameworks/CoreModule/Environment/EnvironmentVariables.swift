//
//  EnvironmentVariables.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 21/02/2021.
//

import Foundation

public struct EnvironmentVariables {
    
    enum PlistKey: String {
        case baseURL
        case firebaseConfigFileName
        case coreDateContainerName

        func value() -> String {
            let description = self.rawValue
            return description.prefix(1).capitalized + description.dropFirst()
        }
    }
    
    public static func getBaseURL() -> String {
        return self.configuration(.baseURL)
    }
    
    public static func getCoreDataContainerName() -> String {
        return self.configuration(.coreDateContainerName)
    }
    
    public static func getFirebaseConfigFileName() -> String {
        return self.configuration(.firebaseConfigFileName)
    }
    
    private static var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        }
        else {
            fatalError("Plist file not found")
        }
    }

    private static func configuration(_ key: PlistKey) -> String {
        guard let keyValue = infoDict[key.value()] as? String else {
            fatalError("Key \(key.value()) Not founded")
        }
        return keyValue
    }
    
    static var isProduction: Bool {
        #if PRODUCTION
        return true
        #else
        return false
        #endif
    }
}
