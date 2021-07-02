//
//  InternetConnectivityServiceProtocol.swift
//  Magento kernel
//
//  Created by Ahmad Mahmoud on 2/13/20.
//

import Foundation

public protocol InternetConnectivityServiceProtocol: AnyObject {
    func isInternetConnectionAvailable () -> Bool
}
