//
//  ResultsView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/9/21.
//

import SwiftUI

struct ResultsView: View {
    
@StateObject private var modelDetailViewModel = ModelDetailViewModel()
@Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
        Text("Rocket Performance")
            .font(.title)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .padding()
        
            
        Text("Problem Parameters")
            .padding()
            VStack{
                ParametersView(singleStageModel: modelDetailViewModel)
                
                Divider()
//                ComputedResultsView(singleStageModel: modelDetailViewModel)
            }
            
        Spacer()
        }
        Spacer()
        Spacer()
    }
}

//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
////        let temp = ModelDetailViewModel()
////        ResultsView(singleStageModel: temp)
//    }
//}
