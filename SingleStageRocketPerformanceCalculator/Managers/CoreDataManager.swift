//
//  CoreDataManager.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/23/21.
//

import Foundation
import CoreData


class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer

    static let shared = CoreDataManager() // Create one CoreDataManager and assess it through "shared"
    
    private init() { // private to prevent creating more than one CoreDataManager
        persistentContainer = NSPersistentContainer(name: "RocketAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initalize Core Data \(error)")
            }
        }
    }
    
    func getModelById( id: NSManagedObjectID) -> Model? {
        
        do {
            return try persistentContainer.viewContext.existingObject(with:id) as? Model
            
        } catch {
                print(error)
                return nil
        }
    }

    func deleteModel(_ model: Model) {
        persistentContainer.viewContext.delete(model)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete movie \(error)")
        }
    }
    
    func getAllModels() -> [Model] {
        
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save a model \(error)")
        }
    }
    
    
}
