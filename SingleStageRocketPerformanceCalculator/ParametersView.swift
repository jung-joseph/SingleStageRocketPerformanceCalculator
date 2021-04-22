//
//  ParametersView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/9/21.
//

import SwiftUI

struct ParametersView: View {
    @ObservedObject var singleStageModel: SingleStageModel

    var body: some View {
        HStack{
            Text("Mass w/o Propellant:")
                .padding(.leading)
            Text(String(format:"%.3f kg",singleStageModel.massWoPropellant))
            Spacer()
        }.padding(.leading, 20)
        HStack{
            Text("Propellant Mass:")
                .padding(.leading)
            Text(String(format:"%.3f kg",singleStageModel.propellantMass))
            Spacer()
        }.padding(.leading, 20)
        HStack{
            Text("Average Mass:")
                .padding(.leading)
            Text(String(format:"%.3f kg",singleStageModel.aveMass))
            Spacer()
        }.padding(.leading, 20)
        HStack{
            Text("Cross Sectional Area:")
                .padding(.leading)
            Text(String(format:"%4.2e m^2",singleStageModel.crossSectionalArea))
            Spacer()
        }.padding(.leading, 20)
        HStack{
            Text("Coefficient of Drag:")
                .padding(.leading)
            Text(String(format:"%.3f",singleStageModel.coefficientOfDrag))
            Spacer()
        }.padding(.leading, 20)
        HStack{
            Text("Average Thrust:")
                .padding(.leading)

            Text(String(format:"%.1f, N",singleStageModel.aveThrust))
            Spacer()

        }.padding(.leading, 20)
        HStack{
            Text("Thrust Duration:")
                .padding(.leading)

            Text(String(format:"%.2f, s",singleStageModel.thrustDuration))
            Spacer()

        }.padding(.leading, 20)
        HStack{
            Text("Temperature:")
                .padding(.leading)

            Text(String(format:"%.2f, deg k",singleStageModel.temperature))
            Spacer()

        }.padding(.leading, 20)
        HStack{
            Text("Rho:")
                .padding(.leading)

            Text(String(format:"%.3f, kg/m^3",singleStageModel.rho))
            Spacer()

        }.padding(.leading, 20)
        HStack{
            Text("g:")
                .padding(.leading)

            Text(String(format:"%.2f, m/s^2",singleStageModel.g))
            Spacer()

        }.padding(.leading, 20)
    }
}

//struct ParametersView_Previews: PreviewProvider {
//    static var previews: some View {
//        ParametersView()
//    }
//}
