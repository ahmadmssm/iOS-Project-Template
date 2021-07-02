//
//  SerializationServiceProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Foundation

public protocol SerializationServiceProtocol {
    func getJSONEncoder() -> JSONEncoder
    func getJSONEncoderEncodingStrategy() -> JSONEncoder.KeyEncodingStrategy
    func getJSONDecoder() -> JSONDecoder
    func getJSONDecoderDecodingStrategy() -> JSONDecoder.KeyDecodingStrategy
    func objectFrom<T: Decodable>(data: Data?, type: T.Type) -> T?
    func objectFrom<T: Decodable>(string: String?, type: T.Type) -> T?
    func objectToData<T: Encodable>(obj: T) -> Data?
    func objectToJSONString<T: Encodable>(obj: T) -> String?
    func dataToString(data: Data?) -> String?
    func objectToDictionary<T: Codable>(obj: T) -> [String: Any]?
    func dataToDictionary(data: Data?) -> [String: Any]?
}
