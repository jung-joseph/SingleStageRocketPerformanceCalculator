//
//  ContentView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var diameter_text: String = ""
    @State private var dragCoeffient_text: String = ""
    @State private var averageThrust_text: String = ""
    @State private var thrustDuration_text: String = ""
    @State private var averageMass_text: String = ""
    @State private var massWoPropellant_text: String = ""
    @State private var propellantMass_text: String = ""
    @State private var temperature_text: String = ""
    
    
    @ObservedObject var singleStageModel = SingleStageModel()
    
    
    var body: some View {
        
        
            
            NavigationView {
                VStack {

                Text("Single Stage Model Rocket Performance Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .padding(.top,0)
                HStack {
                    Text("Mass w/o Propellant:")
                        .foregroundColor(.red)
                    TextField("Enter Rocket Mass w/o Propellant, kg", text: $massWoPropellant_text, onCommit:{
                        singleStageModel.massWoPropellant = Double(massWoPropellant_text) ?? 1.0
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Propellant Mass:")
                        .foregroundColor(.red)
                    TextField("Enter Propellant Mass, kg", text: $propellantMass_text, onCommit:{
                        singleStageModel.propellantMass = Double(propellantMass_text) ?? 1.0
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Diameter:")
                        .foregroundColor(.red)
                    TextField("Enter Rocket Diameter, inches", text: $diameter_text, onCommit:{
                        var diameter = Double(diameter_text) ?? 1.0
                        diameter = diameter * 0.0254
                        singleStageModel.crossSectionalArea = Double.pi * pow((diameter/2.0), 2)
                        
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Drag Coefficient:")
                        .foregroundColor(.red)
                    TextField("Enter Drag Coefficient", text: $dragCoeffient_text, onCommit:{
                        singleStageModel.coefficientOfDrag = Double(dragCoeffient_text) ?? 1.0
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    
                }
                HStack {
                    Text("Average Thrust:")
                        .foregroundColor(.red)
                    TextField("Enter Average Thrust, N", text: $averageThrust_text, onCommit:{
                        singleStageModel.aveThrust = Double(averageThrust_text) ?? 10.0
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    
                }
                HStack {
                    Text("Thrust Duration:")
                        .foregroundColor(.red)
                    TextField("Enter Thrust Duration, s", text: $thrustDuration_text, onCommit:{
                        singleStageModel.thrustDuration = Double(thrustDuration_text) ?? 1.0
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    
                }
                
                HStack {
                    Text("Temperature:")
                        .foregroundColor(.red)
                    TextField("Enter Temperature, deg F", text: $temperature_text, onCommit:{
                        singleStageModel.temperature = Double(temperature_text) ?? 1.0
                        // convert deg F to deg k
                        singleStageModel.temperature = ((singleStageModel.temperature - 32.0) * (5.0/9.0) ) + 273.15
                        
                    })
                    .foregroundColor(.green)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    
                }
                
                
                .padding(.bottom, 50)
                
                
                NavigationLink(destination: ResultsView(singleStageModel: self.singleStageModel).onAppear{
                    // compute averge mass
                    singleStageModel.aveMass = singleStageModel.massWoPropellant + (0.5 * singleStageModel.propellantMass)
                    // compute density
                    singleStageModel.rho = (8.0e4/(287.0 * singleStageModel.temperature))
                    // reset Cd
                    singleStageModel.coefficientOfDrag = Double(dragCoeffient_text) ?? 1.0
                    
                    
                    
                }) {
                    Text("Compute Performance").multilineTextAlignment(.center)
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(20)
                
                
                
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
