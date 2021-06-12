//
//  ModelListViewModel.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/23/21.
//

import Foundation
import CoreData

class ModelListViewModel: ObservableObject {
    
    @Published var models = [ModelViewModel]()
    
    func deleteModel(model: ModelViewModel) {
        let model = CoreDataManager.shared.getModelById(id: model.id)
        if let model = model {
            CoreDataManager.shared.deleteModel(model)
        }
    }
    
    func getAllModels() {
        
        let models = CoreDataManager.shared.getAllModels()
        DispatchQueue.main.async {
            self.models = models.map(ModelViewModel.init)
        }
    }
}


struct ModelViewModel {
    
    let model: Model
    
    var id: NSManagedObjectID {
        return model.objectID
    }
    
    var name: String {
        return model.name ?? ""
    }
    
    var crossSectionalArea: Double {
        return model.crossSectionalArea
    }
    
    var coefficientOfDrag: Double {
        return model.coefficientOfDrag
    }
    
    var thrustDuration: Double {
        return model.thrustDuration
    }
    
    var aveMass: Double {
        return model.aveMass
    }
    
    var massWoPropellant: Double {
        return model.massWoPropellant
    }
    
    var propellantMass: Double {
        return model.propellantMass
    }
    
    var aveThrust: Double {
        return model.aveThrust
    }
    
    var mach: Double {
        return model.mach
    }
    
    var temperature: Double {
        return model.temperature
    }
    
    var targetS: Double {
        return model.targetS
    }
    
    var rho: Double {
        return model.rho
    }
    
    var g: Double {
        return model.g
    }
}
