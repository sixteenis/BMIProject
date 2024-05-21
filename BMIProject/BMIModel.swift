//
//  BIMModel.swift
//  BMIProject
//
//  Created by 박성민 on 5/21/24.
//

import UIKit
//labelset(label: heightLabel, text: "키가 어떻게 되시나요?")
//
//labelset(label: weightLabel, text: "몸무게는 어떻게 되시나요?")
class BMIModel {
    var height: Double?
    var weight: Double?
//    init(height: Double, weight: Double) {
//        self.height = height
//        self.weight = weight
//    }
    func resultBMI() -> Double {
        guard let height = self.height, let weight = self.weight else {return 0.0}
        return weight / (height * height)
    }
    
}


