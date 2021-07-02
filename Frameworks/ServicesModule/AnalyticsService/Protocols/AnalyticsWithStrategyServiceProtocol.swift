//
//  AnalyticsWithStrategyServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 05/05/2021.
//

public protocol AnalyticsWithStrategyServiceProtocol {
    init(analyticsServices: AnalyticsServiceProtocol...)
    func forEachStrategyIn(strategies: [AnalyticsStrategy], action: (AnalyticsServiceProtocol) -> Void)
    func log(userId: Int, strategies: AnalyticsStrategy...)
    func log(event: AnalyticsEvents, strategies: AnalyticsStrategy...)
    func log(event: AnalyticsEvents, params: [String: Any], strategies: AnalyticsStrategy...)
}
