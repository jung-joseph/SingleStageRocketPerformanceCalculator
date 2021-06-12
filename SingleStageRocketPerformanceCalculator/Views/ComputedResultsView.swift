//
//  ComputedResultsView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/9/21.
//

import SwiftUI

struct ComputedResultsView: View {
    var currentModel: ExistingModelViewModel
    
    @State private var targetS_text: String = ""
    
    @State private var iter: Int = 0
    
    @State private var ptC: Double = 0
    
    
    var body: some View {
        
        let bisection = BisectionForCd(singleStageModel: currentModel)
        //        var iter:Int = 0
        NavigationView {
        VStack{
            Text("Computed Values")
                .padding()
            
            
            
            HStack{
                Text("Terminal Velocity:")
                    .padding(.leading)
                Text(String(format:"%.2f m/s",currentModel.terminalVelocity()))
                    .foregroundColor(.red)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Velocity at Burnout:")
                    .padding(.leading)
                
                Text(String(format:"%.2f m/s",currentModel.velocityAtBurnout()))
                    .foregroundColor(.green)
                Spacer()
                
            }.padding(.leading, 20)
            
            
            HStack{
                Text("Altitude at Burnout:")
                    .padding(.leading)
                
                Text(String(format:"%.1f m, %.1f ft",currentModel.sAtBurnOut(), currentModel.sAtBurnOut() * 3.28084))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Maximum Altitude:")
                    .padding(.leading)
                
                Text(String(format:"%.1f m, %.1f ft",currentModel.sMax(), currentModel.sMax() * 3.280084))
                    .foregroundColor(.red)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Time at Maximum Altitude:")
                    .padding(.leading)
                
                Text(String(format:"%.3f s",currentModel.tMax()))
                    .foregroundColor(.green)
                Spacer()
                
            }.padding(.leading, 20)
            
            HStack{
                Text("Mach Number:")
                    .padding(.leading)
                
                Text(String(format:"%.2f ",currentModel.machNumber()))
                    .foregroundColor(.blue)
                Spacer()
                
            }.padding(.leading, 20)
            
            Divider()
            
            Group {
                Text("Update Drag Coefficient if Actual Alt Known")
                    .foregroundColor(.red)
                
                TextField("Enter Max.Alt(if known),m", text: $targetS_text, onCommit:{
                    currentModel.targetS = Double(targetS_text) ?? 0.0
                })
                .foregroundColor(.green)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                
                Button("Solve for a New Cd") {
                    print("Solve Pushed")
                    ptC = bisection.bisect(targetS: currentModel.targetS)

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
