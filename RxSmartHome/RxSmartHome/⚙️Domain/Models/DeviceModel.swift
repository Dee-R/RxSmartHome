//
//  DeviceModel.swift
//  RxSmartHome
//
//  Created by Eddy R on 09/02/2021.
import Foundation

// Model
struct DeviceModel: Codable, Equatable {
    static func == (lhs: DeviceModel, rhs: DeviceModel) -> Bool {
        return lhs.devices == rhs.devices && lhs.user == rhs.user
    }

    var devices: [Device]?
    var user: User?
}

// MARK: - Device
struct Device: Codable, Equatable {
    var id: Int?
    var deviceName: String?
    var productType: ProductType?
    var intensity: Int?
    var mode: String?
    var position, temperature: Int?
}

enum ProductType: String, Codable {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}

// MARK: - User
struct User: Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.address == rhs.address && lhs.birthDate == rhs.birthDate && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }

    var firstName, lastName: String?
    var address: Address?
    var birthDate: Int?
}

// MARK: - Address
struct Address: Codable, Equatable {
    var city: String?
    var postalCode: Int?
    var street, streetCode, country: String?
}
