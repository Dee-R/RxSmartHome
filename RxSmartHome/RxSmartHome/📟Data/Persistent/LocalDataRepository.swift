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

        guard let context = managedObjectContext else { return nil }
        coreDataStack?.saveContext(context) // save

        let lastDataFetched = getDevices()?.last
//        managedObjectContext?.reset()
		return lastDataFetched
    }
    func deleteDevices() {
        // no need save context
        guard let unw_context = managedObjectContext else { fatalError("unw_managedObjectContext") }
        let fetchRequest : NSFetchRequest<DeviceCD> = DeviceCD.fetchRequest()

        if let result = try? unw_context.fetch(fetchRequest) {
            for object in result {
                unw_context.delete(object)
            }
        }
    }
    func deleteDevicesBatch() {
        guard let context = AppDelegate.viewContext else { return }
        let fetchForDeleting: NSFetchRequest<NSFetchRequestResult> = DeviceCD.fetchRequest()
        let request = NSBatchDeleteRequest(fetchRequest: fetchForDeleting)
        _ = try? context.execute(request)
        _ = try? context.save()
    }
    func deleteDevice(_ device: DeviceCD) {
        managedObjectContext?.delete(device)
        guard let unwContext = managedObjectContext else { fatalError("unwManagedObjectContext") }
        coreDataStack?.saveContext(unwContext)
    }
    func getDevices() -> [DeviceCD]? {
        let requestFetch: NSFetchRequest<DeviceCD> = DeviceCD.fetchRequest()
        guard let unwManagedObjectContext = managedObjectContext else { fatalError("unwmanagedObjectContext") }
        do {
            let resultFetchedDevices = try unwManagedObjectContext.fetch(requestFetch)
            return resultFetchedDevices
        } catch let error as NSError {
            print("err : \(error), \(error.userInfo)")
        }
        return nil
    }

}
