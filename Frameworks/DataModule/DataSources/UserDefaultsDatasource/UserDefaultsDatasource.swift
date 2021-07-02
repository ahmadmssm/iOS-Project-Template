//
//  UserDefaultsDatasource.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import ServicesModule

public class UserDefaultsDatasource {
    
    private let simpleDataCachingService: DataCachingServiceProtocol
    
    enum Keys: String {
        case dummy
        
        var description: String {
            return self.rawValue
        }
    }
    
    public init(simpleDataCachingService: DataCachingServiceProtocol) {
        self.simpleDataCachingService = simpleDataCachingService
    }
}
