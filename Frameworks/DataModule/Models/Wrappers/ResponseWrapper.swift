//
//  ResponseWrapper.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 01/03/2021.
//

public struct ResponseWrapper<T: Decodable>: Decodable {
    public let message: String
    public var data: T?
}
