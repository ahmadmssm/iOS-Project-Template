//
//  RestConfigs.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import ServicesModule

public class RestConfigs: RestConfigsProtocol {
    
    public let baseURL: String
    public let loggingService: LoggingServiceProtocol
    public let serializationService: SerializationServiceProtocol
    public let connectivityService: InternetConnectivityServiceProtocol
    
    public init(baseURL: String,
                loggingService: LoggingServiceProtocol,
                serializationService: SerializationServiceProtocol,
                connectivityService: InternetConnectivityServiceProtocol) {
        self.baseURL = baseURL
        self.loggingService = loggingService
        self.serializationService = serializationService
        self.connectivityService = connectivityService
    }
}
