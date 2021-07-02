//
//  Constants.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 17/03/2021.
//

import Foundation

public struct Constants {
    public static var mobileNumberMaxLength: Int { 11 }
    public static var contactUsNumber: Int { 12345 }
    //
    public static var amSymbol: String { "am".localized }
    public static var pmSymbol: String { "pm".localized }
    //
    public enum DateFormat: String {
        case yearMonthDay = "yyyy-MM-dd HH:mm:ss"
        case dayMonthYearTime = "dd MMM yyyy, HH:mm a"
    }
}
