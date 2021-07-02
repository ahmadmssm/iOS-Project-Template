//
//  AnalyticsService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 05/05/2021.
//

public class AnalyticsService: AnalyticsWithStrategyServiceProtocol {
    
    private let analyticsServices: [AnalyticsServiceProtocol]
    
    required public init(analyticsServices: AnalyticsServiceProtocol...) {
        self.analyticsServices = analyticsServices
    }
    
    public func enableLogging() -> Bool {
        return true
    }
    
    public func log(userId: Int, strategies: AnalyticsStrategy...) {
        self.forEachStrategyIn(strategies: strategies) { service in
            service.log(userId: userId)
        }
    }
    
    public func log(event: AnalyticsEvents, strategies: AnalyticsStrategy...) {
        self.forEachStrategyIn(strategies: strategies) { service in
            service.log(event: event)
        }
    }
    
    public func log(event: AnalyticsEvents, params: [String: Any], strategies: AnalyticsStrategy...) {
        self.forEachStrategyIn(strategies: strategies) { service in
            service.log(event: event, params: params)
        }
    }
    
    public func forEachStrategyIn(strategies: [AnalyticsStrategy],
                                  action: (AnalyticsServiceProtocol) -> Void) {
        if(strategies.isEmpty) {
            self.analyticsServices.forEach { action($0) }
        }
        else {
            strategies.forEach { strategy in
                if let analyticsService = self.analyticsServices.first(where: { $0.strategy == strategy }) {
                    action(analyticsService)
                }
                else {
                    fatalError("No AnalyticsServiceProtocol found matching \(strategy) strategy, please provide one through the class initializer!")
                }
            }
        }
    }
}
