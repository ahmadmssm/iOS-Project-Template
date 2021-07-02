//
//  MobileOperatorService.swift
//  ServicesModule
//
//  Created by Ahmad Mahmoud on 14/06/2021.
//

import CoreModule

public class MobileOperatorService: MobileOperatorServiceProtocol {
    
    public init() {}
    
    public func getCarrierName() -> String? {
        SIMInfo.carrierName
    }
    
    public func getNetworkCode() -> String? {
        SIMInfo.mobileNetworkCode
    }
}
