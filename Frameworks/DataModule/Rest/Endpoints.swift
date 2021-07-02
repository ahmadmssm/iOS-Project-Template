//
//  Endpoints.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 22/02/2021.
//

// enum and not class or struct, so it cannot be instantiated
public enum Endpoints {
    public static var refreshToken: String { "token/refresh" }
    static var loginOTP: String { "otps/send" }
    static var register: String { "register"}
    static var logout: String { "logout"}
    static var verifyOTP: String { "otps/verify" }
}
