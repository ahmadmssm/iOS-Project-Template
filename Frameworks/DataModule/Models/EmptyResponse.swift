//
//  EmptyResponse.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 09/04/2021.
//

// This is to be used for any API that returns a result which will not be used in the UI.
public struct EmptyResponse: Codable {
    public init() {}
}
