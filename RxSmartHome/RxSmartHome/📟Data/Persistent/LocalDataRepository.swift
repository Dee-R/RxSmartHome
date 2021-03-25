//  PersistentStorage.swift
import Foundation
import CoreData

// /Users/dee/Library/Developer/CoreSimulator/Devices/89A5B3EC-FD91-41DB-9D3B-D2C659C517E1/data/Containers/Data/Application/8F55E42D-ACCB-4BE0-8E38-E45F014715EB/Library/Application Support/
protocol ILocalDataRepository {
}

class LocalDataRepository: ILocalDataRepository {
    var managedObjectContext: NSManagedObjectContext?
    var coreDataStack: CoreDataStack?

    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    func addDevice(id: Int64) -> DeviceCD? {
        let newData = DeviceCD(context: managedObjectContext!)
        newData.id = id
        debugPrint("L\(#line) 🏵--> ", coreDataStack?.persistentContainer.persistentStoreDescriptions as Any)
        guard let context = managedObjectContext else { return nil }
        coreDataStack?.saveContext(context)
		return newData
    }
}
