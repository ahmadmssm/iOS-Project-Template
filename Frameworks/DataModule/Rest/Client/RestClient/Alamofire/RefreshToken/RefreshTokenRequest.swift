//
//  RefreshTokenRequest.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 12/04/2021.
//

import Alamofire
import ServicesModule

class RefreshTokenRequest {
    
    public var endPoint: String
    public var encoding: Alamofire.ParameterEncoding
    public var headers: HTTPHeaders
    public var parameters: [String: Any] = [:]
    
    public init(oldToken: String?) {
        self.endPoint = Endpoints.refreshToken
        self.encoding = JSONEncoding.default
        self.headers = ["Accept": "application/json",
                        "Authorization": "Bearer \(oldToken ?? "")"]
    }
    
    static func create(oldToken: String?) -> RefreshTokenRequest {
        let refreshTokenRequest = RefreshTokenRequest(oldToken: oldToken)
        return refreshTokenRequest
    }
}
