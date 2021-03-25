//  CoreDataStack.swift
import Foundation
import CoreData

class CoreDataStack {
    static let modelName = AppDelegate.namePersitentContainer // name of Model : RxSmartHomeM
    static let model: NSManagedObjectModel = {
        // locate the file
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    lazy var persistentContainer: NSPersistentContainer = {
        // TODO: Get in appdelegate
        // Container that encapsulates the CoreData stack in the app.
        // Simplifie the creation and management of CoreDataStack by handling
        // creation of managed object model (NSManagedObjectModel)
        // persitent store coordinator (NSPersitentStoreCoordinator)
        // managed object context (NSManagedObjectContext)
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    lazy var viewContextCD: NSManagedObjectContext = {
        // Viewcontext: An object space that you use to manipulate and track changes to managed objects.
        // The managed object context associated with the main queue. (read-only)
        return persistentContainer.viewContext
    }()
    // -Create a new Derived ViewContext
    func newViewContext() -> NSManagedObjectContext {
        // Creates a private managed object context. return new NSManagedObjectContext
        let newViewContext = persistentContainer.newBackgroundContext()
        return newViewContext
    }
    func saveContext(_ viewContextP: NSManagedObjectContext) {
        if viewContextP != viewContextCD {
            saveDerivedContext(viewContextP)
            return
        }
        // continue if they are same
        viewContextP.perform {
            do {
                try viewContextP.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error) , \(error.userInfo)")
            }
        }
    }
    func saveDerivedContext(_ viewContext: NSManagedObjectContext) {
        viewContext.perform {
            do {
                try viewContext.save()
            } catch let error as NSError {
                fatalError("██░░░ L\(#line) 🚧🚧 err : \(error), \(error.userInfo) 🚧🚧 ")
            }
            self.saveContext(self.viewContextCD)
        }
    }
    func pathSql() -> String? {
        let objc = persistentContainer.persistentStoreDescriptions
        let urlSql =  objc.first?.url?.absoluteURL.absoluteString
        return urlSql
    }
}
