//
//  APIBuilderFactory.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 15/04/2021.
//

import Alamofire

class APIBuilderFactory {
    
    static func create<T: Encodable>(route: Route,
                                     headers: [String: String] = [:],
                                     params: T) -> EncodableAPIBuilder<T> {
        return EncodableAPIBuilder<T>(route: route)
            .set(headers: headers)
            .set(params: params)
            .set(jsonKeysEncodingStrategy: .convertToSnakeCase)
    }
    
    static func create(route: Route,
                       headers: [String: String] = [:],
                       params: [String: Any]? = nil,
                       encoding: Alamofire.ParameterEncoding = JSONEncoding.default) -> APIBuilder {
        return APIBuilder(route: route).set(headers: headers).set(params: params, encoding: encoding)
    }
}
