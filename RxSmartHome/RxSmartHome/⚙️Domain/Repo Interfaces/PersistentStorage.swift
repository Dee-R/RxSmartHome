//  PersistentStorage.swift
import Foundation
import CoreData

protocol IPersistentStorage {
//    var database: [Int: Device] {get set}
//    func addDevice(device: Device) -> Int
//    func retrieveDevice(id: Int) -> Device?
//    func deleteDevice(id: Int)
//    func updateDevice(id: Int, device: Device)
//    func retrieveAllDevice() -> [Int: Device]
//    func deviceExist(id: Int) -> Bool
}

class PersistentStorage: IPersistentStorage {
}

final class CoreDataStorage {
	static let shared = CoreDataStorage()
    private init() {}
    // Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RxSmartHome")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
	// DataSaving Support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
