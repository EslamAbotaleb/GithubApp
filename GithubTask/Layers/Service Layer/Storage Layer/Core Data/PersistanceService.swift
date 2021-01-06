//
//  PersistanceService.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/6/21.
//

import Foundation
import CoreData

class PersistanceService {
    
    //MARK:- shared Object
    private init() {
        
    }
    
    static let shared = PersistanceService()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GithubTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK:- Save Data into coredata
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Succsfflly")
                NotificationCenter.default.post(name: NSNotification.Name("PersistedDataUpdated"), object: nil)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK:- fetch values  from coreData
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
       
        do {
          let objects = try context.fetch(request)
            completion(objects)
        } catch {
            print(error)
            completion([])
        }
        
    }
}
