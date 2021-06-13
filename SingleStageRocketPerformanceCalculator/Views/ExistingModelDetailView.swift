//
//  ExistingModelDetailView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/26/21.
//

import SwiftUI

struct ExistingModelDetailView: View {
    
    var model: ModelViewModel
    
    @StateObject private var existingModelVM = ExistingModelViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showResultsSheet: Bool = false
    
    //    var modelDetailVM: ModelDetailViewModel
    
    @State private var name: String = ""
    @State private var diameter_text: String = ""
    @State private var dragCoeffient_text: String = ""
    @State private var averageThrust_text: String = ""
    @State private var thrustDuration_text: String = ""
    @State private var averageMass_text: String = ""
    @State private var massWoPropellant_text: String = ""
    @State private var propellantMass_text: String = ""
    @State private var temperature_text: String = ""
    
   
    
    var body: some View {
        
        
        VStack{
            Text("Rocket Model")
            HStack {
                Text("Model Name: ")
                    .foregroundColor(.red)
                //            TextField("\(model.name)", text: $editModelVM.name, onCommit:{
                //                editModelVM.name = editModelVM.name
                //            })
                TextField("\(model.name)", text: $existingModelVM.name, onCommit:{
                    
                    print("model.name \(model.name) existingModelVM.name \(existingModelVM.name)")
                    
                    //                editModelVM.name = model.name
                    print("After assignment")
                    print("model.name \(model.name) existModelVM.name \(existingModelVM.name)")
                    
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            }
            HStack {
                Text("Mass w/o Propellant:")
                    .foregroundColor(.red)
                TextField("\(model.massWoPropellant)", text: $massWoPropellant_text, onCommit:{
                    existingModelVM.massWoPropellant = Double(massWoPropellant_text) ?? 1.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            }
            HStack {
                Text("Propellant Mass:")
                    .foregroundColor(.red)
                TextField("\(model.propellantMass)", text: $propellantMass_text, onCommit:{
                    existingModelVM.propellantMass = Double(propellantMass_text) ?? 1.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            }
            HStack {
                Text("Diameter:")
                    .foregroundColor(.red)
                TextField("\(2.0 * pow((model.crossSectionalArea)/(Double.pi), 0.5))", text: $diameter_text, onCommit:{
                    var diameter = Double(diameter_text) ?? 1.0
                    diameter = diameter * 0.0254
                    existingModelVM.crossSectionalArea = Double.pi * pow((diameter/2.0), 2)
                    
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            }
            HStack {
                Text("Drag Coefficient:")
                    .foregroundColor(.red)
                TextField("\(model.coefficientOfDrag)", text: $dragCoeffient_text, onCommit:{
                    existingModelVM.coefficientOfDrag = Double(dragCoeffient_text) ?? 1.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
            }
            HStack {
                Text("Average Thrust:")
                    .foregroundColor(.red)
                TextField("\(model.aveThrust)", text: $averageThrust_text, onCommit:{
                    existingModelVM.aveThrust = Double(averageThrust_text) ?? 10.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
            }
            HStack {
                Text("Thrust Duration:")
                    .foregroundColor(.red)
                TextField("\(model.thrustDuration)", text: $thrustDuration_text, onCommit:{
                    existingModelVM.thrustDuration = Double(thrustDuration_text) ?? 1.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
            }
            
            HStack {
                Text("Temperature:")
                    .foregroundColor(.red)
                TextField("\((model.temperature - 273.15) * (9.0/5.0) + 32)", text: $temperature_text, onCommit:{
                    let temperature = Double(temperature_text) ?? 1.0
                    //                    // convert deg F to deg k
                    existingModelVM.temperature = ((temperature - 32.0) * (5.0/9.0) ) + 273.15
                    
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
            }
            
            Group {
                
                Button("Save") {
                    existingModelVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                
                Button("Compute Performance") {
                    print("Compute Button Pushed")
                    self.showResultsSheet.toggle()
                    
                    existingModelVM.name = model.name
                    existingModelVM.crossSectionalArea = model.crossSectionalArea
                    existingModelVM.coefficientOfDrag = model.coefficientOfDrag
                    existingModelVM.thrustDuration = model.thrustDuration
                    existingModelVM.aveMass = model.massWoPropellant + (0.5 * model.propellantMass)
                    existingModelVM.massWoPropellant = model.massWoPropellant
                    existingModelVM.propellantMass = model.propellantMass
                    existingModelVM.aveThrust = model.aveThrust
                    existingModelVM.mach = model.mach
                    existingModelVM.temperature = model.temperature
                    existingModelVM.targetS = model.targetS
//                    existingModelVM.rho = model.rho
                    existingModelVM.g = model.g
                    
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 10)
                .sheet(isPresented: $showResultsSheet) {
                    
                                ComputedResultsView(currentModel: existingModelVM)
                            }
            }
        }
    }
}

//struct EditModelDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditModelDetailView(model: model)
//    }
//}
