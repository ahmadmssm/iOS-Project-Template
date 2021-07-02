//
//  AnalyticsServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 05/05/2021.
//

public protocol AnalyticsServiceProtocol {
    var strategy: AnalyticsStrategy { get }
    //
    init()
    func enableLogging() -> Bool
    func log(userId: Int)
    func log(event: AnalyticsEvents)
    func log(event: AnalyticsEvents, params: [String: Any])
    //
    static func create() -> AnalyticsServiceProtocol
}

public extension AnalyticsServiceProtocol {
    func doIfEnabled(action: () -> Void) {
        if(self.enableLogging()) {
            action()
        }
    }
    //
    static func create() -> AnalyticsServiceProtocol { return Self() }
}
