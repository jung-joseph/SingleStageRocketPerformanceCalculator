//
//  ModelDetailViewModel.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/23/21.
//

import Foundation


class ModelDetailViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var crossSectionalArea: Double = 1.0
    @Published var coefficientOfDrag: Double = 1.0
    @Published var thrustDuration: Double = 1.0
    @Published var aveMass: Double = 1.0
    @Published var massWoPropellant: Double = 0.0
    @Published var propellantMass: Double = 0.0
    @Published var aveThrust: Double = 10.0
    @Published var mach: Double = 0.0
    @Published var temperature: Double = 0.0
    @Published var targetS: Double = 0.0
    @Published var rho: Double = 0.948 // kg/m^3
    @Published var g: Double = 9.81 // m/sec^2
    
    init() {
        print("Called ModelDetailViewModel init")
        
    }
    
    func save() {
        let manager = CoreDataManager.shared
        let model = Model(context: manager.persistentContainer.viewContext)
        model.name = name
        model.crossSectionalArea = crossSectionalArea
        model.coefficientOfDrag = coefficientOfDrag
        model.thrustDuration = thrustDuration
        model.aveMass = aveMass
        model.massWoPropellant = massWoPropellant
        model.propellantMass = propellantMass
        model.aveThrust = aveThrust
        model.mach = mach
        model.temperature = temperature
        model.targetS = targetS
        model.rho = rho
        model.g = g
        
        manager.save()
    }
}
