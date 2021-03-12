//
//  AppDelegate.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation
import AppKit

class AppDelegate {
  let validator: Validator
  let dataManager: DataManager
  let holeFiller: HoleFiller
  
  init() {
    self.validator = Validator()
    self.dataManager = DataManager()
    self.holeFiller = HoleFiller()
  }
  
  func main(arguments: [String]) {
    let optionalInputParameters = validator.validateInputArguments(arguments: arguments)
    
    guard let inputParameters = optionalInputParameters else {
      print("❌ Input parameters are not valid. Operation aborted")
      return
    }
    
    print("""
    Your parameters:
          🔘 imagePath: \(inputParameters.imagePath)
          🔘 maskPath: \(inputParameters.maskPath)
          🔘 zeta: \(inputParameters.zeta)
          🔘 epsilon: \(inputParameters.epsilon)
          🔘 connectivity: \(inputParameters.connectivity)
          🔘 resultImagePath: \(inputParameters.resultImagePath)
    """)
    
    guard let holeFillingParameters = dataManager.getHoleFillingParameters(inputParameters: inputParameters) else {
      print("❌ Could not process images. Operation aborted")
      return
    }
    
    guard let filledHoleMatrix = holeFiller.getFilledHoleMatrix(parameters: holeFillingParameters) else {
      print("❌ Wrong mask resulution. Operation aborted")
      return
    }
    
    dataManager.convertToImageAndSave(matrix: filledHoleMatrix, path: inputParameters.resultImagePath)
  }
}
