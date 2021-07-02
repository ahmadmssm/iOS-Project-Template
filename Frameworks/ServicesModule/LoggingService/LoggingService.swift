//
//  LoggingService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Foundation

public class LoggingService: LoggingServiceProtocol {
    
    public init() {}
    
    public func shouldPrint() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    public func print(_ items: Any...) {
        if(shouldPrint()) {
            print(items, separator: "", terminator: "\n")
        }
    }
    
    public func print(_ items: Any..., separator: String, terminator: String) {
        if(shouldPrint()) {
            Swift.print(items, separator: separator, terminator: terminator)
        }
    }
    
    public func prettyPrint(_ text: String) {
        self.prettyPrint(text, separator: " ", terminator: "\n")
    }
    
    public func prettyPrint(_ text: String, separator: String, terminator: String) {
        if(shouldPrint()) {
            if let data = text.data(using: .utf8) {
                self.prettyPrint(data)
            }
            else {
                debugPrint(text)
            }
        }
    }
    
    public func prettyPrint(_ data: Data?) {
        self.prettyPrint(data, separator: "", terminator: "\n")
    }
    
    public func prettyPrint(_ data: Data?, separator: String, terminator: String) {
        if(shouldPrint()) {
            guard let data = data else {
                debugPrint("No response body")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                debugPrint(json)
            }
            catch {
                debugPrint("Invalid JSON")
            }
        }
    }
}
