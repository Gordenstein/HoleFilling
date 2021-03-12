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
    do {
      let inputParameters = try validator.validateInputArguments(arguments: arguments)
      
      validator.printValidInputParameters(parameters: inputParameters)
      
      let holeFillingParameters = try dataManager.getHoleFillingParameters(inputParameters: inputParameters)
      
      let filledHoleMatrix = try holeFiller.getFilledHoleMatrix(parameters: holeFillingParameters)
      
      try dataManager.convertToImageAndSave(matrix: filledHoleMatrix, path: inputParameters.resultImagePath)
      
      print("🏁 Operation finished successfully")
      
    } catch (let error) {
      defer {
        if let projectError = error as? ProjectError,
           projectError == .missedParameters ||
            projectError == .excessParameters ||
            projectError == .wrongParametersFormat {
          validator.printInstruction()
        }
      }
      
      print("Error occurred:")
      if let projectError = error as? ProjectError {
        print(projectError.errorDescription)
      } else {
        print(error.localizedDescription)
      }
      print("❌ Operation aborted")
    }
  }
}
