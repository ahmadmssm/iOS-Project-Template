//
//  OTPViewDelegate.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 27/02/2021.
//

public protocol OTPViewDelegate: AnyObject {
    func didRemoveOTP()
    func didFillOTP(_ opt: String)
}
