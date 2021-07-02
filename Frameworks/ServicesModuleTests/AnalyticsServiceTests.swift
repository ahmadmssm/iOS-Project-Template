//
//  AnalyticsServiceTests.swift
//  ServicesModuleTests
//
//  Created by Ahmad Mahmoud on 10/06/2021.
//

import XCTest
@testable import ServicesModule

class AnalyticsServiceTests: XCTestCase {
    
    func testExample() throws {
        let analyticsService: AnalyticsWithStrategyServiceProtocol = AnalyticsService()
        analyticsService.log(event: .dummyEvent, strategies: .firebase)
    }
    
    func testExample2() throws {
        let firebaseAnalytics: AnalyticsServiceProtocol = FirebaseAnalyticsService.create()
        firebaseAnalytics.log(event: .dummyEvent)
    }
}
