//
//  LoggingService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Foundation

public protocol LoggingServiceProtocol {
    func shouldPrint() -> Bool
    func print(_ items: Any...)
    func print(_ items: Any..., separator: String, terminator: String)
    func prettyPrint(_ text: String)
    func prettyPrint(_ text: String, separator: String, terminator: String)
    func prettyPrint(_ data: Data?)
    func prettyPrint(_ data: Data?, separator: String, terminator: String)
}
