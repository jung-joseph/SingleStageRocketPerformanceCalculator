//
//  ComputedResultsView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/9/21.
//

import SwiftUI

struct ComputedResultsView: View {
    @ObservedObject var singleStageModel: SingleStageModel
    @State private var targetS_text: String = ""
    
    @State private var iter: Int = 0

    
    var body: some View {
        
        let bisection = BisectionForCd(fromsingleStageModel: singleStageModel)
//        var iter:Int = 0
        
        VStack{
            Text("Computed Values")
                .padding()
            
            
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
            
            HStack {
                Text("Update Cd")
                    .foregroundColor(.red)
                TextField("Max.Alt(if known),m", text: $targetS_text, onCommit:{
                    singleStageModel.targetS = Double(targetS_text) ?? 0.0
                    
                    if (singleStageModel.targetS != 0.0 ) {
                        iter = bisection.bisect(targetS: singleStageModel.targetS)
                    }


                
                    
                    
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
            }
            if singleStageModel.targetS != 0.0 {
               
                    HStack{
                        
                        Text("Updated Cd:")
                            .padding(.leading)
                        
                        Text(String(format:"%.2f",singleStageModel.coefficientOfDrag))
                            .foregroundColor(.red)
                        Text("(\(iter) Iterations)")
                        Spacer()

                    }.padding(.leading, 20)
            }
        }
        
    }
}

struct ComputedResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let temp = SingleStageModel()
        ComputedResultsView(singleStageModel: temp)
    }
}
