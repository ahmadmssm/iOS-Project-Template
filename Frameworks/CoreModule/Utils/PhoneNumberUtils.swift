//
//  PhoneNumberUtils.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/04/2021.
//

import UIKit.UITextField

public class PhoneNumberUtils {
    
    public static func getPhoneNumberWithoutCountryCode(_ phoneNumber: String?) -> String? {
        guard let phoneNumber = phoneNumber else { return nil }
        return phoneNumber.count == 11 ? phoneNumber : String(phoneNumber.dropFirst(2))
    }
    
    public static func getPhoneNumberWithCountryCode(_ phoneNumber: Int) -> String {
        return String(phoneNumber).prefix(3) == "200" ? "\(phoneNumber)" : "200\(phoneNumber)"
    }
    
    public static func getPhoneNumberWithCountryCode(_ phoneNumberText: String?) -> String {
        if let countryKey = phoneNumberText?.prefix(3), countryKey == "200" {
            return phoneNumberText!
        }
        else {
            let phoneNumber = Int(phoneNumberText ?? "0") ?? 0
            return self.getPhoneNumberWithCountryCode(phoneNumber)
        }
    }
    
    public static func trimExtraPhoneNumberDigits(for textField: UITextField?) {
        if let text = textField?.text {
            textField?.text = String(text.prefix(Constants.mobileNumberMaxLength))
        }
    }
}
