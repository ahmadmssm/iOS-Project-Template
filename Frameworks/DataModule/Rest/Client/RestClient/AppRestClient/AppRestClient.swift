//
//  AppRestClient.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import CoreModule

public class AppRestClient: AlamofireRestClient {
    
    private let refreshTokenProtocol: RefreshTokenProtocol
    private let localeRequestIntercepter: LocaleRequestIntercepter
    
    public init(restConfigsProtocol: RestConfigsProtocol,
                refreshTokenProtocol: RefreshTokenProtocol,
                localeRequestIntercepter: LocaleRequestIntercepter) {
        self.refreshTokenProtocol = refreshTokenProtocol
        self.localeRequestIntercepter = localeRequestIntercepter
        super.init(restConfigsProtocol: restConfigsProtocol)
    }
    
    public override func getRefreshTokenProtocol() -> RefreshTokenProtocol? {
        return self.refreshTokenProtocol
    }
    
    public override func getAdditionalRequestIntercepters() -> [RequestIntercepterProtocol] {
        return [self.localeRequestIntercepter]
    }
    
    public override func getAdditionalHeaders() -> [String: String] {
        return ["Accept": "application/json"]
    }
}
