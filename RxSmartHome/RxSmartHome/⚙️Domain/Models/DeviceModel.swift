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

    let devices: [Device]?
    let user: User?
}

// MARK: - Device
struct Device: Codable, Equatable {
    let id: Int?
    let deviceName: String?
    let productType: ProductType?
    let intensity: Int?
    let mode: String?
    let position, temperature: Int?
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

    let firstName, lastName: String?
    let address: Address?
    let birthDate: Int?
}

// MARK: - Address
struct Address: Codable, Equatable {
    let city: String?
    let postalCode: Int?
    let street, streetCode, country: String?
}
