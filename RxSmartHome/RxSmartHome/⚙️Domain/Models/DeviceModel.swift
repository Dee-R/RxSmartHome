//
//  DeviceModel.swift
//  RxSmartHome
//
//  Created by Eddy R on 09/02/2021.

import Foundation

/// Model
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





/*
 {
 "devices": [
 {
 "id": 1,
 "deviceName": "Lampe - Cuisine",
 "intensity": 50,
 "mode": "ON",
 "productType": "Light"
 },
 {
 "id": 2,
 "deviceName": "Volet roulant - Salon",
 "position": 70,
 "productType": "RollerShutter"
 },
 {
 "id": 3,
 "deviceName": "Radiateur - Chambre",
 "mode": "OFF",
 "temperature": 20,
 "productType": "Heater"
 },
 {
 "id": 4,
 "deviceName": "Lampe - Salon",
 "intensity": 100,
 "mode": "ON",
 "productType": "Light"
 },
 {
 "id": 5,
 "deviceName": "Volet roulant",
 "position": 0,
 "productType": "RollerShutter"
 },
 {
 "id": 6,
 "deviceName": "Radiateur - Salon",
 "mode": "OFF",
 "temperature": 18,
 "productType": "Heater"
 },
 {
 "id": 7,
 "deviceName": "Lampe - Grenier",
 "intensity": 0,
 "mode": "ON",
 "productType": "Light"
 },
 {
 "id": 8,
 "deviceName": "Volet roulant - Salle de bain",
 "position": 70,
 "productType": "RollerShutter"
 },
 {
 "id": 9,
 "deviceName": "Radiateur - Salle de bain",
 "mode": "OFF",
 "temperature": 20,
 "productType": "Heater"
 },
 {
 "id": 10,
 "deviceName": "Lampe - Salle de bain",
 "intensity": 36,
 "mode": "ON",
 "productType": "Light"
 },
 {
 "id": 11,
 "deviceName": "Volet roulant",
 "position": 33,
 "productType": "RollerShutter"
 },
 {
 "id": 12,
 "deviceName": "Radiateur - WC",
 "mode": "ON",
 "temperature": 19,
 "productType": "Heater"
 }
 ],
 "user": {
 "firstName": "John",
 "lastName": "Doe",
 "address": {
 "city": "Issy-les-Moulineaux",
 "postalCode": 92130,
 "street": "rue Michelet",
 "streetCode": "2B",
 "country": "France"
 },
 "birthDate": 813766371000
 }
 }
 */
