//
//  EncodableAPIBuilder.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 15/04/2021.
//

import Alamofire
import Foundation

public class EncodableAPIBuilder<T: Encodable> {
    
    public let route: Route
    public var headers: [String: String] = [:]
    public var params: T?
    public var encoding: Alamofire.ParameterEncoder = JSONParameterEncoder.default
    
    public init(route: Route) {
        self.route = route
    }
    
    func set(headers: [String: String]) -> EncodableAPIBuilder {
        self.headers = headers
        return self
    }
    
    func set(params: T?) -> EncodableAPIBuilder {
        // Get request can not have body
        if(self.route.method == .get && self.encoding is JSONParameterEncoder) {
            self.params = nil
        }
        else {
            self.params = params
        }
        return self
    }
    
    func set(jsonKeysEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase) -> EncodableAPIBuilder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = jsonKeysEncodingStrategy
        self.encoding = JSONParameterEncoder(encoder: encoder)
        return self
    }
}
