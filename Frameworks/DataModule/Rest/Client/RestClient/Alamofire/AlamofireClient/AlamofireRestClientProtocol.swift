//
//  AlamofireRestClientProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import Alamofire

public protocol AlamofireRestClientProtocol: RestClientProtocol {
    func createAlamofireSession() -> Session
    func getEventMonitorsList() -> [EventMonitor]
    func createAlamofireRequestFactory() -> AlamofireRequestFactory
    func createAPIRequestExecuter<T: APIRequestExecuterProtocol>() -> T
}
