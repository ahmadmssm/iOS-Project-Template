//
//  RequestIntercepterProtocol.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 17/02/2021.
//

import Alamofire
import Foundation

public protocol RequestIntercepterProtocol {
     func modifyURLRequest(_ urlRequest: inout URLRequest)
}
