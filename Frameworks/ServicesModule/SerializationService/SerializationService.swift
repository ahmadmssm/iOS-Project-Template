//
//  SerializationService.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Foundation

public class SerializationService: SerializationServiceProtocol {
    
    private lazy var jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = getJSONEncoderEncodingStrategy()
        return encoder
    }()
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = getJSONDecoderDecodingStrategy()
        return decoder
    }()
    private let loggingService: LoggingServiceProtocol
    
    public init(loggingService: LoggingServiceProtocol) {
        self.loggingService = loggingService
    }
    
    public func getJSONEncoder() -> JSONEncoder {
        return jsonEncoder
    }
    
    public func getJSONEncoderEncodingStrategy() -> JSONEncoder.KeyEncodingStrategy {
        return JSONEncoder.KeyEncodingStrategy.convertToSnakeCase
    }
    
    public func getJSONDecoder() -> JSONDecoder {
        return jsonDecoder
    }
    
    public func getJSONDecoderDecodingStrategy() -> JSONDecoder.KeyDecodingStrategy {
        return JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
    }
    
    public func objectFrom<T>(data: Data?, type: T.Type) -> T? where T: Decodable {
        do {
            return data == nil ? nil : try getJSONDecoder().decode(type.self, from: data!)
        }
        catch {
            self.loggingService.print("😞😞 Failed to decode Data to type \(T.Type.self)")
            return nil
        }
    }
    
    public func objectFrom<T>(string: String?, type: T.Type) -> T? where T: Decodable {
        if (string != nil) {
            let data = Data(string!.utf8)
            return self.objectFrom(data: data, type: T.self)
        }
        return nil
    }
    
    public func objectToData<T>(obj: T) -> Data? where T: Encodable {
        do {
            return try getJSONEncoder().encode(obj)
        }
        catch {
            self.loggingService.print("😞😞 Failed to encode type \(T.Type.self) to Data")
            return nil
        }
    }
    
    public func objectToJSONString<T>(obj: T) -> String? where T: Encodable {
        if let data = self.objectToData(obj: obj) {
            return String(decoding: data, as: UTF8.self)
        }
        return nil
    }
    
    public func dataToString(data: Data?) -> String? {
        return data == nil ? nil : String(data: data!, encoding: .utf8)
    }
    
    public func objectToDictionary<T: Codable>(obj: T) -> [String: Any]? {
        return self.dataToDictionary(data: self.objectToData(obj: obj)) { error in
            self.loggingService.print("😞😞 Failed to convert type \(T.Type.self) to Dictionary with error \(error.localizedDescription)")
        }
    }
    
    public func dataToDictionary(data: Data?) -> [String: Any]? {
        return self.dataToDictionary(data: data) { error in
            self.loggingService.print("😞😞 Failed to convert Data to Dictionary \(error.localizedDescription)")
        }
    }
    
    public func dataToDictionary(data: Data?,
                                 errorAction: ((_ error: Error) -> Void)) -> [String: Any]? {
        if(data != nil) {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                return dictionary
            }
            catch {
                errorAction(error)
            }
        }
        else {
            self.loggingService.print("😞😞 Data is nil")
        }
        return nil
    }
}
