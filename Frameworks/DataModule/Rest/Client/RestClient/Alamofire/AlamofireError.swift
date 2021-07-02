//
//  AlamofireError.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/02/2021.
//

import Alamofire
import Foundation

public enum AlamofireError: Swift.Error, LocalizedError {
    
    /// The request was successful, but the status code is not acceptable as a successful response.
    case serverError(_ error: AFError, _ errorData: Data?, _ statusCode: Int, _ request: URLRequest?)
    /// Alamofire specific error. Error creating Alamofire Endpoint, parsing JSON/Image/String, invalid status code received.
    case alamofireError(originalError: AFError?)
    
    public var errorDescription: String? {
        switch self {
        case .serverError(let error, _, _, _):
            return error.localizedDescription
        case .alamofireError(let error):
            return error?.localizedDescription
        }
    }
    
    public var statusCode: Int? {
        switch self {
        case .serverError(_, _, let statusCode, _):
            return statusCode
        default:
            break
        }
        return nil
    }
}
