//
//  OtherAPIs.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 15/04/2021.
//

public class OtherAPIs: BaseAPI {
    
    public func getCreateNewAddressAPI(address: Address) -> EncodableAPIBuilder<Address> {
        return APIBuilderFactory.create(route: .post("Endpoints.otherEndpoint"), params: address)
    }
}
