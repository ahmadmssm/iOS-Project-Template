//
//  RemoteLoggingServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 05/05/2021.
//

public protocol RemoteLoggingServiceProtocol {
    func log(userId: Int)
    func log(message: String)
    func log(error: Error)
    func log(value: Any, key: String)
    func log(KeysAndValues: [String: Any])
}
