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
}
