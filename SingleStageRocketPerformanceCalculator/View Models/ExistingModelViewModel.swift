//
//  ExistingModelViewModel.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 6/9/21.
//

import Foundation

class ExistingModelViewModel: ObservableObject {
    
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
    
    func terminalVelocity() -> Double {
        let num = (aveThrust - (aveMass * g))
        if num >= 0.0 {
            return pow((num)/(0.5*rho*crossSectionalArea*coefficientOfDrag), 0.5)
        } else {
            return 0.0
        }
    }

    func velocityAtBurnout( ) -> Double {
        let b = ((rho * crossSectionalArea * coefficientOfDrag) / (2.0 * aveMass)) * self.terminalVelocity()
        return self.terminalVelocity()*tanh(b * thrustDuration)
    }

    func sAtBurnOut() -> Double {
        let b = ((rho * crossSectionalArea * coefficientOfDrag) / (2.0 * aveMass)) * self.terminalVelocity()
        return ((2.0 * aveMass) / (rho*crossSectionalArea*coefficientOfDrag)) * log(cosh(b * thrustDuration))
    }
    
    func timeCoast() -> Double {
        let d = pow((massWoPropellant*g)/(0.5 * rho * crossSectionalArea * coefficientOfDrag), 0.5)
        return d/g * atan(self.velocityAtBurnout()/d)
    }
    
    func sMax() -> Double {
        let d = pow((massWoPropellant*g)/(0.5 * rho * crossSectionalArea * coefficientOfDrag), 0.5)

        return self.sAtBurnOut() + ((massWoPropellant/(rho*crossSectionalArea*coefficientOfDrag)) * log( pow((self.velocityAtBurnout()/d), 2.0) + 1.0 ))
    }
    
    func tMax() -> Double {
        let d = pow((massWoPropellant*g)/(0.5 * rho * crossSectionalArea * coefficientOfDrag), 0.5)
        let tCoast = (d/g) * atan(self.velocityAtBurnout()/d)
        return thrustDuration + tCoast
    }
    
    func machNumber() -> Double {
        let speedOfSound = pow((1.4 * 287.0 * self.temperature), 0.5)
        return self.velocityAtBurnout()/speedOfSound
    }
}
