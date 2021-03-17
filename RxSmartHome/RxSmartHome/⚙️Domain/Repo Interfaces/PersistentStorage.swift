//  PersistentStorage.swift
import Foundation
import CoreData
import UIKit

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
	static var shared = PersistentStorage()
    private init() {}

    private(set) var devices = [Device]()

    
}


class DataController: NSObject {
    var managedObjectContext: NSManagedObjectContext

    init(completionClosure: @escaping () -> ()) {
        //This resource is the same name as your xcdatamodeldd contained in your project
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)

        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc

        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
                DispatchQueue.main.sync(execute: completionClosure)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}
