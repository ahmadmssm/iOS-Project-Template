//
//  RestModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import DataModule
import CoreModule

extension Resolver {
    
    static func registerRestModules() {
        registerRestClientDependencies()
        registerRestClientModules()
        registerRestAPIsModules()
    }
    
    static func registerRestClientDependencies() {
        register { LocaleRequestIntercepter(languageManagerProtocol: resolve()) }
        register {
            RefreshToken(baseURL: EnvironmentVariables.getBaseURL(),
                         jwtService: resolve(),
                         sessionService: resolve(),
                         serializationService: resolve(),
                         loggingService: resolve()) as RefreshTokenProtocol
        }
        register {
            RestConfigs(baseURL: EnvironmentVariables.getBaseURL(),
                        loggingService: resolve(),
                        serializationService: resolve(),
                        connectivityService: resolve()) as RestConfigsProtocol
        }
    }
    
    static func registerRestClientModules() {
        register {
            AppRestClient(restConfigsProtocol: resolve(),
                          refreshTokenProtocol: resolve(),
                          localeRequestIntercepter: resolve()) as RestClientProtocol
        }
        register {  _ -> RxRequestExecuterProtocol in
            let restClient: RestClientProtocol = resolve()
            let requestExecuter: RxRequestExecuter = restClient.createAPIRequestExecuter()
            return requestExecuter
        }.scope(.application)
    }
    
    static func registerRestAPIsModules() {
        register { OtherAPIs() }
        register { AuthenticationAPIs() }
    }
}
