//
//  ComputedResultsView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/9/21.
//

import SwiftUI

struct ComputedResultsView: View {
    var singleStageModel: ExistingModelViewModel
    
    @State private var targetS_text: String = ""
    
    @State private var iter: Int = 0
    
    @State private var ptC: Double = 0
    
    
    var body: some View {
        
        let bisection = BisectionForCd(fromsingleStageModel: singleStageModel)
        //        var iter:Int = 0
        NavigationView {
        VStack{
            Text("Computed Values")
                .padding()
            
            //            Group{
            //                Text("name \(singleStageModel.name)")
            //                Text("crossSection \(singleStageModel.crossSectionalArea)")
            //                Text("Cd \(singleStageModel.coefficientOfDrag)")
            //                Text("aveDuration \(singleStageModel.thrustDuration)")
            //                Text("aveMass \(singleStageModel.aveMass)")
            //            }
            //            Group{
            //                Text("aveWoPropellant \(singleStageModel.massWoPropellant)")
            //                Text("PropellantMass \(singleStageModel.propellantMass)")
            //                Text("aveThrust \(singleStageModel.aveThrust)")
            //                Text("mach \(singleStageModel.mach)")
            //                Text("temperature \(singleStageModel.temperature)")
            //                Text("rho \(singleStageModel.rho)")
            //                Text("g \(singleStageModel.g)")
            //            }
            
            HStack{
                Text("Terminal Velocity:")
                    .padding(.leading)
                Text(String(format:"%.2f m/s",singleStageModel.terminalVelocity()))
                    .foregroundColor(.red)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Velocity at Burnout:")
                    .padding(.leading)
                
                Text(String(format:"%.2f m/s",singleStageModel.velocityAtBurnout()))
                    .foregroundColor(.green)
                Spacer()
                
            }.padding(.leading, 20)
            
            
            HStack{
                Text("Altitude at Burnout:")
                    .padding(.leading)
                
                Text(String(format:"%.1f m, %.1f ft",singleStageModel.sAtBurnOut(), singleStageModel.sAtBurnOut() * 3.28084))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Maximum Altitude:")
                    .padding(.leading)
                
                Text(String(format:"%.1f m, %.1f ft",singleStageModel.sMax(), singleStageModel.sMax() * 3.280084))
                    .foregroundColor(.red)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Time at Maximum Altitude:")
                    .padding(.leading)
                
                Text(String(format:"%.3f s",singleStageModel.tMax()))
                    .foregroundColor(.green)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Mach Number:")
                    .padding(.leading)
                
                Text(String(format:"%.2f ",singleStageModel.machNumber()))
                    .foregroundColor(.blue)
                Spacer()
                
            }.padding(.leading, 20)
            
            Divider()
            
            Group {
                Text("Update Drag Coefficient if Actual Alt Known")
                    .foregroundColor(.red)
                
                TextField("Enter Max.Alt(if known),m", text: $targetS_text, onCommit:{
                    singleStageModel.targetS = Double(targetS_text) ?? 0.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
                Button("Solve for a New Cd") {
                    print("Solve Pushed")
                    ptC = bisection.bisect(targetS: singleStageModel.targetS)

                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 10)
                HStack {
                Text("Updated Cd")
                                                .foregroundColor(.red)
                Text(String(format:"%.2f",ptC))
                }
            }
 
        }
    }
    }
    
}


//struct ComputedResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let temp = EditModelViewModel()
////        ComputedResultsView(singleStageModel: temp)
//    }
//}