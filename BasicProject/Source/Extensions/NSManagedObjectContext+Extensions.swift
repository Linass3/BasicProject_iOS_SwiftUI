//
//  NSManagedObjectContext+Extensions.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 02/04/2025.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {
    func performSave() {
        do {
            try self.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ entity: T.Type) -> [T]? {
        let request = NSFetchRequest<T>(entityName: entity.entity().name ?? .emptyString)
        
        do {
            return try self.fetch(request)
        } catch {
            print("Error fetching \(entity.entity().name ?? "unknown") entity : \(error.localizedDescription)")
            return nil
        }
    }
}
