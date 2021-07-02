//
//  SIMInfo.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 14/06/2021.
//

import CoreTelephony

public class SIMInfo {
    
    public static var physicalSIMInfo: CTCarrier? {
        let telephonyNetworkInfo = CTTelephonyNetworkInfo()
        // This means the device is a dual dim device, try to get SIM info.
        if let simInfo = telephonyNetworkInfo.serviceSubscriberCellularProviders?.first?.value {
            return simInfo
        }
        else if let simInfo = telephonyNetworkInfo.serviceSubscriberCellularProviders,
                let carrierInfo = simInfo["serviceSubscriberCellularProvider"] {
            return carrierInfo
        }
        else {
            return telephonyNetworkInfo.subscriberCellularProvider
        }
    }
    
    public static var carrierName: String? {
        return self.physicalSIMInfo?.carrierName
    }
    
    public static var mobileCountryCode: String? {
        return self.physicalSIMInfo?.mobileCountryCode
    }
    
    public static var mobileNetworkCode: String? {
        return self.physicalSIMInfo?.mobileNetworkCode
    }
}
