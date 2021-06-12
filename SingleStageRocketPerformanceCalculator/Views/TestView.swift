//
//  TestView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 6/10/21.
//

import SwiftUI

struct TestView: View {
    
    var model: ModelViewModel
    var body: some View {
        Text("Model Name \(model.name)")
    }
}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
