//
//  Validator.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation

class Validator {
  
  init() {
  }
  
  func validateInputArguments(arguments: [String]) -> InputParameters? {
    let utilityArguments = arguments.count - 1
    if utilityArguments < 6 {
      print("Some parameters are missed. Parameters \(utilityArguments)/6. Check the input parameters")
      return nil
    }
    
    if utilityArguments > 6 {
      print("There are excess parameters. Parameters \(utilityArguments)/6. Check the input parameters")
      return nil
    }
    
    if let zeta = Float(arguments[3]),
       let epsilon = Float(arguments[4]),
       let relatedPixels = Int(arguments[5]) {
      
      let imagePath = arguments[1]
      let holePath = arguments[2]
      let resultImagePath = arguments[6]
      
      var connectivity = PixelConnectivity.fourConnected
      if relatedPixels == 8 {
        connectivity = .eightConnected
      }
      
      return InputParameters(imagePath: imagePath,
                             maskPath: holePath,
                             zeta: zeta,
                             epsilon: epsilon,
                             connectivity: connectivity,
                             weightingFunction: detaultWeightingFunction(zeta: zeta, epsilon: epsilon),
                             resultImagePath: resultImagePath)
    } else {
      print("Some parameters are in wrong format. Check the input parameters")
      return nil
    }
  }
}
