//
//  DeviceEntity+CoreDataProperties.swift
//  RxSmartHome
//
//  Created by Eddy R on 12/03/2021.
//
//

import Foundation
import CoreData


extension DeviceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceEntity> {
        return NSFetchRequest<DeviceEntity>(entityName: "DeviceEntity")
    }

    @NSManaged public var name: String?

}

extension DeviceEntity: Identifiable {
}
