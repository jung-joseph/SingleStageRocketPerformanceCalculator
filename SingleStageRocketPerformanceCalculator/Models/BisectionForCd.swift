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
    var solutionFound: Bool
    
    init(singleStageModel: ExistingModelViewModel) {
        self.singleStageModel = singleStageModel
        ptA = 0.1
        ptB = 2.0
        ptC = (ptA + ptB)/2.0
        tol = 0.1
        residual = 100.0
        solutionFound = false
    }
    
    func bisect(targetS: Double) -> Bool {
        //start the iteration
        self.iteration = 0
        self.singleStageModel.coefficientOfDrag = ptA
        fatA = self.singleStageModel.sMax()
        self.singleStageModel.coefficientOfDrag = ptB
        fatB = self.singleStageModel.sMax()
        self.singleStageModel.coefficientOfDrag = ptC
        fatC = self.singleStageModel.sMax()
        self.residual = targetS - fatC
        
// Check that a solution is captured between ptA and ptB
        print("fA \(fatA)  fB \(fatB)")
        print("Starting Residuals \(targetS - fatA)  \(targetS - fatB)")
        if ((targetS-fatA) * (targetS - fatB)) > 0.0 {
            solutionFound = false
            return solutionFound
        }
        
        while (abs(self.residual) >= self.tol) && self.iteration <= 20 {
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
//            self.newCoefficientOfDrag = ptC
            fatC = self.singleStageModel.sMax()
            self.residual = targetS - fatC

                print("ptC \(ptC) fC \(fatC) residual \(self.residual)")
        }
        
        print("In bisect \(self.iteration)  \(self.ptC) \(self.fatC)")
        self.newCoefficientOfDrag = ptC
        singleStageModel.coefficientOfDrag = ptC
        
        if(abs(self.residual) <= tol) {
            self.solutionFound = true
            return self.solutionFound
        } else {
            return false
        }
        
//        print("iteration \(self.iteration)")
    }
    
}
