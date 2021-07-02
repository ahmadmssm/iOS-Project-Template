//
//  RestClientServicesProvider.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import ServicesModule

public protocol RestConfigsProtocol {
    var baseURL: String { get }
    var loggingService: LoggingServiceProtocol { get }
    var serializationService: SerializationServiceProtocol { get }
    var connectivityService: InternetConnectivityServiceProtocol { get }
}
