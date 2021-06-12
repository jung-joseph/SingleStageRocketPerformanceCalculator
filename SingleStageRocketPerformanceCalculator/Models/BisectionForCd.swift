//
//  BisectionForCd.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/14/21.
//

import Foundation

class BisectionForCd: ObservableObject{
    @Published var newCoefficientOfDrag: Double = 0.0
    @Published var iteration: Int = 0
    
    
    var singleStageModel: ExistingModelViewModel
    var tol: Double
    var residual: Double
    var ptA: Double
    var ptB: Double
    var ptC: Double
    var fatA: Double = 0.0
    var fatB: Double = 0.0
    var fatC: Double = 0.0
    var targetS: Double = 0.0
    
    init(singleStageModel: ExistingModelViewModel) {
        self.singleStageModel = singleStageModel
        ptA = 0.1
        ptB = 1.0
        ptC = (ptA + ptB)/2.0
        tol = 0.1
        residual = 100.0
    }
    
    func bisect(targetS: Double) -> Double {
        //start the iteration
        self.iteration = 0
        self.singleStageModel.coefficientOfDrag = ptA
        fatA = self.singleStageModel.sMax()
        self.singleStageModel.coefficientOfDrag = ptB
        fatB = self.singleStageModel.sMax()
        self.singleStageModel.coefficientOfDrag = ptC
        fatC = self.singleStageModel.sMax()
        self.residual = targetS - fatC
        
//        print("iteration \(iteration)")
//        print("ptA \(ptA) fatA \(fatA)")
//        print("ptB \(ptB) fatB \(fatB)")
//        print("ptC \(ptC) fatC \(fatC)")
//
//        print("residual \(self.residual)")
        
        while (abs(self.residual) >= self.tol) && self.iteration <= 10 {
            self.iteration += 1
            
            if ((targetS-fatA) * (targetS - fatC)) > 0.0 {
                fatA = fatC
                ptA = ptC
            } else {
                fatB = fatC
                ptB = ptC
            }
            ptC = (ptA + ptB) / 2.0
            self.singleStageModel.coefficientOfDrag = ptC
            fatC = self.singleStageModel.sMax()
            self.residual = targetS - fatC

        }
        print("In bisect \(self.iteration)  \(self.ptC) \(self.fatC)")
        self.singleStageModel.coefficientOfDrag = ptC
        return self.ptC
//        print("iteration \(self.iteration)")
    }
    
}
