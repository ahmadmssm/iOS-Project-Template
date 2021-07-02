//
//  Address.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 30/03/2021.
//

public struct Address: Codable, Hashable {
    
    public let id: Int?
    public var title: String?
    public var fullName: String?
    public var phoneNumber: String?
    public var cityId: Int?
    public var areaId: Int?
    public var deliveryFee: Double?
    public var address: String?
    public var isDefault: Bool?
    public var street: String?
    public var building: String?
    public var floor: String?
    public var apartment: String?
    public var landmark: String?
    public var isSelected: Bool?
    
    init() {
        self.id = nil
    }
    
    public mutating func toggleIsSelected() {
        self.isSelected = !(self.isSelected ?? false)
    }
    
    public static func create() -> Address {
        return Self()
    }
}
