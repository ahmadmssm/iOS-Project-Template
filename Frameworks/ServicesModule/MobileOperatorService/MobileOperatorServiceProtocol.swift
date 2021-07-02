//
//  MobileOperatorServiceProtocol.swift
//  ServicesModule
//
//  Created by Ahmad Mahmoud on 14/06/2021.
//

public protocol MobileOperatorServiceProtocol {
    func getCarrierName() -> String?
    func getNetworkCode() -> String?
}
