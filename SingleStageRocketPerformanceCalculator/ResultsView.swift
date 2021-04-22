//
//  ResultsView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/9/21.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var singleStageModel: SingleStageModel
    
    var body: some View {
        VStack {
        Text("Rocket Performance")
            .font(.title)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .padding()
        
            
        Text("Problem Parameters")
            .padding()
            VStack{
                ParametersView(singleStageModel: singleStageModel)
                
                Divider()
                ComputedResultsView(singleStageModel: singleStageModel)
            }
            
        Spacer()
        }
        Spacer()
        Spacer()
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let temp = SingleStageModel()
        ResultsView(singleStageModel: temp)
    }
}
