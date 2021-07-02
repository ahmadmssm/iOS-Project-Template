//
//  APIBuilder.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 15/04/2021.
//

import Alamofire

public class APIBuilder {
    
    public let route: Route
    public var headers: [String: String] = [:]
    public var params: [String: Any]?
    public var encoding: Alamofire.ParameterEncoding = JSONEncoding.default
        
    public init(route: Route) {
        self.route = route
    }
    
    func set(headers: [String: String]) -> APIBuilder {
        self.headers = headers
        return self
    }
    
    func set(params: [String: Any]? = nil, encoding: Alamofire.ParameterEncoding) -> APIBuilder {
        self.encoding = encoding
        // Get request can not have body
        if(self.route.method == .get && self.encoding is JSONEncoding) {
            self.params = nil
        }
        else {
            self.params = params
        }
        return self
    }
}
