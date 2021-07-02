//
//  ServicesModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import CoreModule
import ServicesModule

extension Resolver {
    static func registerServicesModules() {
        register { LoggingService() as LoggingServiceProtocol }.scope(.application)
        register {
            SerializationService(loggingService: resolve()) as SerializationServiceProtocol
        }.scope(.application)
        register {
            SessionService(serializationService: resolve(),
                               simpleDataCachingService: resolve()) as SessionServiceProtocol
        }.scope(.application)
        register {
            SimpleDataCachingService(loggingService: resolve(),
                                         serializationService: resolve()) as DataCachingServiceProtocol
        }.scope(.application)
        register {
            InternetConnectivityService() as InternetConnectivityServiceProtocol
        }.scope(.application)
        register { JWTService() as JWTServiceProtocol }.scope(.application)
        register { MobileOperatorService() as MobileOperatorServiceProtocol }
    }
}
