//
//  CoreDataStack.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 01/04/2025.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
        
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    private init() { }
}
