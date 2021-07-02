//
//  CoreDataContextProvider.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/03/2021.
//

import CoreData

public class CoreDataContextProvider {
    
    public static func createNSManagedObjectContext(containerName: String) -> NSManagedObjectContext {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container.viewContext
    }
}
